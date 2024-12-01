import 'dart:convert';
import 'dart:io';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AWSService {
  // Thay thế bằng credentials thực của bạn
  static final String _accessKeyId = dotenv.env['AMAZON_ACCESS_KEY_ID'] ?? '';
  static final String _secretAccessKey =
      dotenv.env['AMAZON_SECRET_ACCESS_KEY'] ?? '';
  static const String _region = 'ap-southeast-2';

  static Future<Map<String, dynamic>> compareFaceWithImage(
      String sourceImagePath, String targetImagePath) async {
    try {
      final credentials = AwsClientCredentials(
        accessKey: _accessKeyId,
        secretKey: _secretAccessKey,
      );

      final rekognition = Rekognition(
        region: _region,
        credentials: credentials,
      );

      final sourceImageBase64 =
          base64Encode(await File(sourceImagePath).readAsBytes());
      final targetImageBase64 =
          base64Encode(await File(targetImagePath).readAsBytes());

      final sourceImageBytes = base64Decode(sourceImageBase64);
      final targetImageBytes = base64Decode(targetImageBase64);

      final response = await rekognition.compareFaces(
        sourceImage: Image(bytes: sourceImageBytes),
        targetImage: Image(bytes: targetImageBytes),
        similarityThreshold: 80.0,
      );

      if (response.faceMatches != null && response.faceMatches!.isNotEmpty) {
        final similarity = response.faceMatches!.first.similarity ?? 0.0;
        return {
          'isMatch': similarity >= 95.0,
          'similarity': similarity,
        };
      } else {
        return {
          'isMatch': false,
          'similarity': 0.0,
          'error': 'No faces found to compare',
        };
      }
    } catch (e) {
      String errorMessage = 'Unknown error occurred';

      if (e.toString().contains('UnrecognizedClientException')) {
        errorMessage = 'Invalid AWS credentials. Please contact support.';
      } else if (e.toString().contains('InvalidParameterException')) {
        errorMessage = 'Invalid image format or no face detected';
      } else if (e.toString().contains('InvalidImageFormatException')) {
        errorMessage = 'Unsupported image format';
      }

      return {
        'isMatch': false,
        'similarity': 0.0,
        'error': errorMessage,
      };
    }
  }
}
