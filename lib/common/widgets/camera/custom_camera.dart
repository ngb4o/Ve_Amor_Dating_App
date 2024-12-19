import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ve_amor_app/common/widgets/camera/camera_service.dart';
import 'package:ve_amor_app/data/services/face_detector/face_detector_service.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({super.key});

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> with SingleTickerProviderStateMixin {
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

      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

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
            final double movement = (currentPosition - _lastFacePosition!).distance;

            if (movement > FaceDetectorService.movementThreshold) {
              // Phát hiện chuyển động mạnh
              _lastStableTime = DateTime.now();
              if (_isCountingDown) {
                _resetDetection();
              }
            } else if (_lastStableTime != null) {
              // Kiểm tra thời gian ổn định
              if (DateTime.now().difference(_lastStableTime!) > FaceDetectorService.stabilityDuration) {
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
                  _isFaceInPosition ? 'Keep your face steady in the frame' : 'Move your face to the center',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isFaceInPosition ? Colors.green : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                      ),
                    ],
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
    final bool isFaceSizeValid =
        faceWidth >= (ovalWidth * 0.4) && // Khuôn mặt phải chiếm ít nhất 30% chiều rộng khung
            faceWidth <= (ovalWidth * 0.9) && // Không được quá 90% chiều rộng khung
            faceHeight >= (ovalHeight * 0.4) && // Chiều cao tương tự
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
      ..strokeWidth = 4.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final ovalWidth = size.width * 0.75;
    final ovalHeight = ovalWidth * 1.3;

    final oval = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Vẽ overlay đen với độ mờ thấp hơn
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(oval);
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, backgroundPaint);

    if (isInPosition && progress != null) {
      // Vẽ hiệu ứng gradient xanh
      final gradient = SweepGradient(
        colors: [
          Colors.green, // Màu xanh chính
          Colors.green,
          Colors.green,
          Colors.green,
          Colors.green
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        startAngle: -1.5708,
        // Bắt đầu từ vị trí 12h (-90 độ)
        endAngle: 4.71239,
        // Kết thúc tại vị trí 12h (270 độ)
        transform: GradientRotation(progress! * 2 * 3.14159), // Xoay gradient
      ).createShader(oval);

      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..shader = gradient;

      // Vẽ đường viền progress
      final progressPath = Path();
      progressPath.addArc(
        oval,
        -1.5708, // Bắt đầu từ đỉnh
        progress! * 2 * 3.14159, // Vẽ theo tiến độ
      );
      canvas.drawPath(progressPath, progressPaint);
    } else {
      // Vẽ viền bình thường khi không trong trạng thái đếm ngược
      paint.color = isInPosition ? TColors.primary : Colors.white;
      canvas.drawOval(oval, paint);
    }

    // Thêm các chấm định vị ở 4 góc oval
    if (isInPosition) {
      final dotPaint = Paint()
        ..color = Colors.green // Đổi màu chấm thành xanh khi khuôn mặt đúng vị trí
        ..style = PaintingStyle.fill;

      final dotRadius = 6.0;
      final corners = [
        Offset(centerX - ovalWidth / 2, centerY - ovalHeight / 2), // Top left
        Offset(centerX + ovalWidth / 2, centerY - ovalHeight / 2), // Top right
        Offset(centerX - ovalWidth / 2, centerY + ovalHeight / 2), // Bottom left
        Offset(centerX + ovalWidth / 2, centerY + ovalHeight / 2), // Bottom right
      ];

      for (final corner in corners) {
        canvas.drawCircle(corner, dotRadius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(FaceBorderPainter oldDelegate) =>
      oldDelegate.isInPosition != isInPosition || oldDelegate.progress != progress;
}
