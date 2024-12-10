import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ve_amor_app/common/widgets/camera/camera_service.dart';
import 'package:ve_amor_app/data/services/face_detector/face_detector_service.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({super.key});

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen>
    with SingleTickerProviderStateMixin {
  final CameraService _cameraService = CameraService();
  final FaceDetectorService _faceDetectorService = FaceDetectorService();

  bool _isCameraInitialized = false;
  bool _isFaceInPosition = false;
  bool _isProcessing = false;
  List<Face> _faces = [];

  // Tracking variables
  Offset? _lastFacePosition;
  DateTime? _lastStableTime;
  bool _isCountingDown = false;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _setupAnimationController();
  }

  void _setupAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _takePhoto();
        }
      });
  }

  Future<void> _initializeServices() async {
    final controller = await _cameraService.initializeCamera();
    if (controller != null) {
      await controller.startImageStream((image) => _processCameraImage(image));
      setState(() => _isCameraInitialized = true);
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      if (!mounted) return;

      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(image.width.toDouble(), image.height.toDouble());

      final inputImageData = InputImageMetadata(
        size: imageSize,
        rotation: InputImageRotation.rotation270deg,
        format: InputImageFormat.bgra8888,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: inputImageData,
      );

      final faces = await _faceDetectorService.detectFaces(inputImage);

      if (!mounted) return;

      setState(() {
        _faces = faces;
        if (faces.length > 1) {
          _resetDetection();
        } else if (faces.length == 1) {
          final face = faces.first;
          final Rect boundingBox = face.boundingBox;
          final Offset currentPosition = boundingBox.center;

          // Kiểm tra chuyển động
          if (_lastFacePosition != null) {
            final double movement =
                (currentPosition - _lastFacePosition!).distance;

            if (movement > FaceDetectorService.movementThreshold) {
              // Phát hiện chuyển động mạnh
              _lastStableTime = DateTime.now();
              if (_isCountingDown) {
                _resetDetection();
              }
            } else if (_lastStableTime != null) {
              // Kiểm tra thời gian ổn định
              if (DateTime.now().difference(_lastStableTime!) >
                  FaceDetectorService.stabilityDuration) {
                // Tiếp tục xử lý nhận diện bình thường
                _processStableFace(boundingBox, imageSize);
              }
            }
          }

          _lastFacePosition = currentPosition;
          if (_lastStableTime == null) {
            _lastStableTime = DateTime.now();
          }
        } else {
          _resetDetection();
        }
      });
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _takePhoto() async {
    try {
      final image = await _cameraService.controller!.takePicture();
      if (mounted) {
        Navigator.pop(context, image.path);
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: 1.0,
            child: Center(
              child: CameraPreview(_cameraService.controller!),
            ),
          ),
          CustomPaint(
            size: Size.infinite,
            painter: FaceBorderPainter(
              isInPosition: _isFaceInPosition,
              progress: _isCountingDown ? _animationController!.value : null,
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  _isFaceInPosition
                      ? 'Keep your face steady in the frame'
                      : 'Move your face to the center',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isFaceInPosition ? Colors.green : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _faces.isEmpty
                        ? "No face detected"
                        : _faces.length > 1
                            ? "Only one face allowed"
                            : "Face detected",
                    style: TextStyle(
                      color: _faces.length == 1 ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Thêm phương thức reset
  void _resetDetection() {
    _isFaceInPosition = false;
    _lastFacePosition = null;
    _lastStableTime = null;
    if (_isCountingDown) {
      _isCountingDown = false;
      _animationController!.reset();
    }
  }

  // Tách logic xử lý khuôn mặt ổn đnh thành phương thức riêng
  void _processStableFace(Rect boundingBox, Size imageSize) {
    final double ovalX = imageSize.width * 0.25;
    final double ovalY = imageSize.height * 0.25;
    final double ovalWidth = imageSize.width * 0.5;
    final double ovalHeight = ovalWidth * 1.35;

    final double faceCenterX = boundingBox.center.dx;
    final double faceCenterY = boundingBox.center.dy;

    // Giảm độ dung sai từ 30px xuống 20px
    final bool isFaceInOval = faceCenterX >= (ovalX - 20) &&
        faceCenterX <= (ovalX + ovalWidth + 20) &&
        faceCenterY >= (ovalY - 20) &&
        faceCenterY <= (ovalY + ovalHeight + 20);

    // Thêm kiểm tra kích thước khuôn mặt
    final double faceWidth = boundingBox.width;
    final double faceHeight = boundingBox.height;
    final bool isFaceSizeValid = faceWidth >=
            (ovalWidth *
                0.55) && // Khuôn mặt phải chiếm ít nhất 50% chiều rộng khung
        faceWidth <= (ovalWidth * 0.9) && // Không được quá 90% chiều rộng khung
        faceHeight >= (ovalHeight * 0.55) && // Chiều cao tương tự
        faceHeight <= (ovalHeight * 0.9);

    if (mounted) {
      bool newIsFaceInPosition = isFaceInOval && isFaceSizeValid;

      // Bắt đầu đếm ngược khi mặt vừa vào đúng vị trí
      if (newIsFaceInPosition && !_isFaceInPosition && !_isCountingDown) {
        _isCountingDown = true;
        _animationController!.forward(from: 0);
      }
      // Dừng đếm ngược nếu mặt không còn đúng vị trí
      else if (!newIsFaceInPosition && _isCountingDown) {
        _isCountingDown = false;
        _animationController!.reset();
      }

      _isFaceInPosition = newIsFaceInPosition;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _cameraService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }
}

class FaceBorderPainter extends CustomPainter {
  final bool isInPosition;
  final double? progress;

  FaceBorderPainter({
    required this.isInPosition,
    this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    if (isInPosition && progress != null) {
      // Vẽ viền xanh theo tiến độ, bắt đầu từ 12h
      paint.shader = SweepGradient(
        colors: [Colors.green, Colors.green, Colors.white, Colors.white],
        stops: [0.0, progress!, progress!, 1.0],
        startAngle: -1.5708,
        // Bắt đầu từ vị trí 12h (-90 độ)
        endAngle: 4.71239,
        // Kết thúc tại vị trí 12h (270 độ)
        transform: GradientRotation(-1.5708), // Xoay gradient để bắt đầu từ 12h
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ));
    } else {
      paint.color = isInPosition ? Colors.green : Colors.white;
    }

    final backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final ovalWidth = size.width * 0.8;
    final ovalHeight = ovalWidth * 1.3;

    final oval = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Vẽ overlay đen
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(oval);
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, backgroundPaint);

    // Vẽ viền oval với hiệu ứng phát sáng khi đang loading
    if (isInPosition && progress != null) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);
      glowPaint.shader = paint.shader;
      canvas.drawOval(oval, glowPaint);
    }

    // Vẽ viền chính
    canvas.drawOval(oval, paint);
  }

  @override
  bool shouldRepaint(FaceBorderPainter oldDelegate) =>
      oldDelegate.isInPosition != isInPosition ||
      oldDelegate.progress != progress;
}
