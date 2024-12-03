import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  CameraController? controller;

  Future<CameraController?> initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return null;

    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );

    try {
      await controller!.initialize();
      return controller;
    } catch (e) {
      print('Error initializing camera: $e');
      return null;
    }
  }

  void dispose() {
    controller?.stopImageStream();
    controller?.dispose();
  }
}
