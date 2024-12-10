import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter/material.dart';

class FaceDetectorService {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  static const double movementThreshold = 20.0;
  static const Duration stabilityDuration = Duration(milliseconds: 200);

  Future<List<Face>> detectFaces(InputImage inputImage) async {
    return await _faceDetector.processImage(inputImage);
  }

  bool isFaceInPosition(Rect boundingBox, Size imageSize) {
    final double ovalX = imageSize.width * 0.25;
    final double ovalY = imageSize.height * 0.25;
    final double ovalWidth = imageSize.width * 0.5;
    final double ovalHeight = ovalWidth * 1.35;

    final bool isFaceInOval =
        _checkFacePosition(boundingBox, ovalX, ovalY, ovalWidth, ovalHeight);
    final bool isFaceSizeValid =
        _checkFaceSize(boundingBox, ovalWidth, ovalHeight);

    return isFaceInOval && isFaceSizeValid;
  }

  bool _checkFacePosition(Rect boundingBox, double ovalX, double ovalY,
      double ovalWidth, double ovalHeight) {
    return boundingBox.center.dx >= (ovalX - 20) &&
        boundingBox.center.dx <= (ovalX + ovalWidth + 20) &&
        boundingBox.center.dy >= (ovalY - 20) &&
        boundingBox.center.dy <= (ovalY + ovalHeight + 20);
  }

  bool _checkFaceSize(Rect boundingBox, double ovalWidth, double ovalHeight) {
    return boundingBox.width >= (ovalWidth * 0.55) &&
        boundingBox.width <= (ovalWidth * 0.9) &&
        boundingBox.height >= (ovalHeight * 0.55) &&
        boundingBox.height <= (ovalHeight * 0.9);
  }

  void dispose() {
    _faceDetector.close();
  }
}
