import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Size;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:io';

enum CheatingBehavior {
  normal,
  noFaceDetected,
  multipleFaces,
  lookingLeft,
  lookingRight,
  spoofing,
  error,
}

class CheatingDetectionState {
  final CheatingBehavior behavior;
  final String message;
  final DateTime timestamp;

  CheatingDetectionState({
    required this.behavior,
    required this.message,
    required this.timestamp,
  });
}

class FaceDetectionService {
  final FaceDetector _faceDetector;
  final double _minFaceRatio = 0.15;
  final double _maxFaceRatio = 0.65;
  final double _cheatingAngleThreshold = 25.0;

  FaceDetectionService()
      : _faceDetector = FaceDetector(
          options: FaceDetectorOptions(
            enableLandmarks: true,
            enableClassification: true,
            performanceMode: FaceDetectorMode.accurate,
          ),
        );

  Future<CheatingDetectionState> processCameraImage(
    CameraImage image,
    CameraDescription camera,
  ) async {
    try {
      final inputImage = await _prepareInputImage(image, camera);
      if (inputImage == null) {
        return CheatingDetectionState(
          behavior: CheatingBehavior.error,
          message: 'Không thể xử lý hình ảnh',
          timestamp: DateTime.now(),
        );
      }

      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return CheatingDetectionState(
          behavior: CheatingBehavior.noFaceDetected,
          message: 'Vui lòng đưa khuôn mặt vào khung hình',
          timestamp: DateTime.now(),
        );
      }

      if (faces.length > 1) {
        return CheatingDetectionState(
          behavior: CheatingBehavior.multipleFaces,
          message: 'Phát hiện nhiều khuôn mặt',
          timestamp: DateTime.now(),
        );
      }

      final face = faces.first;
      final faceSize = face.boundingBox.width * face.boundingBox.height;
      final imageSize =
          inputImage.metadata!.size.width * inputImage.metadata!.size.height;
      final faceRatio = faceSize / imageSize;

      if (faceRatio < _minFaceRatio) {
        return CheatingDetectionState(
          behavior: CheatingBehavior.spoofing,
          message: 'Vui lòng đưa mặt gần hơn',
          timestamp: DateTime.now(),
        );
      }

      if (faceRatio > _maxFaceRatio) {
        return CheatingDetectionState(
          behavior: CheatingBehavior.spoofing,
          message: 'Vui lòng đưa mặt xa hơn',
          timestamp: DateTime.now(),
        );
      }

      if (face.headEulerAngleY != null) {
        if (face.headEulerAngleY! < -_cheatingAngleThreshold) {
          return CheatingDetectionState(
            behavior: CheatingBehavior.lookingLeft,
            message: 'Vui lòng nhìn thẳng vào camera',
            timestamp: DateTime.now(),
          );
        }
        if (face.headEulerAngleY! > _cheatingAngleThreshold) {
          return CheatingDetectionState(
            behavior: CheatingBehavior.lookingRight,
            message: 'Vui lòng nhìn thẳng vào camera',
            timestamp: DateTime.now(),
          );
        }
      }

      return CheatingDetectionState(
        behavior: CheatingBehavior.normal,
        message: 'Đã phát hiện khuôn mặt',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return CheatingDetectionState(
        behavior: CheatingBehavior.error,
        message: 'Có lỗi xảy ra: $e',
        timestamp: DateTime.now(),
      );
    }
  }

  Future<InputImage?> _prepareInputImage(
    CameraImage image,
    CameraDescription camera,
  ) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final InputImageRotation rotation = Platform.isAndroid
        ? InputImageRotation.rotation270deg
        : InputImageRotation.rotation0deg;

    final inputImageFormat = Platform.isAndroid
        ? InputImageFormat.yuv420
        : InputImageFormat.bgra8888;

    final inputImageData = InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: inputImageFormat,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: inputImageData,
    );
  }

  void dispose() {
    _faceDetector.close();
  }
}
