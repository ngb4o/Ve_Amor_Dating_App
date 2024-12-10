import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/features/personalization/models/user_model.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/data/services/amazon/aws_compare_face.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../generated/assets.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Reactive user object
  Rx<UserModel> user = UserModel.empty().obs;

  // Reactive variables
  final hidePassword = true.obs;

  // Indicates whether an image is being uploaded
  final imageUploading = false.obs;

  // Index of the image currently being deleted
  final deletingIndex = RxnInt();

  // Indicates whether the profile is being loaded
  final profileLoading = false.obs;

  // User repository instance
  final userRepository = Get.put(UserRepository());

  // List of user's profile pictures
  RxList<String> newPhotos = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch user record when the controller is initialized
    fetchUserRecord();
  }

  /// Fetch the user's profile details from the repository
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      // Clear existing photos before adding new ones
      newPhotos.clear();
      // Add new photos from user data
      newPhotos.addAll(user.profilePictures);
      this.user(user);
    } catch (e) {
      user.value = UserModel.empty();
      newPhotos.clear(); // Clear photos on error too
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user details to the database after registration
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh the user record
      await fetchUserRecord();

      if (userCredentials != null) {
        final newUser = UserModel(
            id: userCredentials.user!.uid,
            username: user.value.username,
            email: user.value.email.isNotEmpty
                ? user.value.email
                : userCredentials.user!.email ?? '',
            phoneNumber: user.value.phoneNumber,
            profilePictures: user.value.profilePictures,
            dateOfBirth: user.value.dateOfBirth,
            gender: user.value.gender,
            wantSeeing: user.value.wantSeeing,
            lifeStyle: user.value.lifeStyle,
            identityVerificationQR: user.value.identityVerificationQR,
            identityVerificationFaceImage:
                user.value.identityVerificationFaceImage,
            findingRelationship: user.value.findingRelationship,
            likes: user.value.likes,
            nopes: user.value.nopes,
            matches: user.value.matches,
            location: user.value.location,
            zodiac: user.value.zodiac,
            sports: user.value.sports,
            pets: user.value.pets);

        // Save new data to Firestore
        await userRepository.saveUserRecord(newUser);

        TLoaders.successSnackBar(
          title: 'Data Saved',
          message: 'Your information has been successfully saved.',
        );
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. Please try again.',
      );
    }
  }

  /// Delete a specific profile image from the user's account
  Future<void> deleteImage(String imageUrl, int index) async {
    try {
      deletingIndex.value = index; // Set the index of the image being deleted

      // Call repository to delete the image
      await userRepository.deleteProfileImage(imageUrl);

      // Update the photos list after deletion
      newPhotos.remove(imageUrl);
      user.value.profilePictures = newPhotos; // Update user data
      user.refresh(); // Refresh UI bindings

      TLoaders.successSnackBar(
        title: 'Image Deleted',
        message: 'The image has been successfully removed from your profile.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to delete image: $e',
      );
    } finally {
      deletingIndex.value = null; // Clear the deleting index
    }
  }

  /// Upload a new image to Firebase and update the user's profile
  Future<void> pushImageFirebase(String filePath) async {
    try {
      // Start face comparison process
      TFullScreenLoader.openLoadingDialog(
        'Comparing your photo with verification face...',
        Assets.animations141594AnimationOfDocer,
      );

      // Verify that user has a verification face image
      if (user.value.identityVerificationFaceImage.isEmpty) {
        TLoaders.errorSnackBar(
          title: 'Verification Required',
          message: 'Please complete face verification first.',
        );
        return;
      }

      // Download verification face image to local temporary file
      final verificationImageFile = await _downloadVerificationImage();
      if (verificationImageFile == null) {
        TLoaders.errorSnackBar(
          title: 'Verification Error',
          message: 'Could not access verification image. Please try again.',
        );
        return;
      }

      // Compare faces using AWS Rekognition
      final result = await AWSService.compareFaceWithImage(
        verificationImageFile.path,
        filePath,
      );

      // Delete temporary file
      await verificationImageFile.delete();

      TFullScreenLoader.stopLoading();

      // Handle comparison errors
      if (result.containsKey('error')) {
        TLoaders.errorSnackBar(
          title: 'Face Verification Error',
          message: result['error'],
        );
        return;
      }

      final similarity = result['similarity'].toStringAsFixed(1);

      // Check if faces match
      if (!result['isMatch']) {
        TLoaders.errorSnackBar(
          title: 'Face Verification Failed',
          message:
              'Face similarity: $similarity%. Must be at least 95% similar to your verification photo.',
        );
        return;
      }

      // If faces match, proceed with upload
      imageUploading.value = true;

      // Upload the image and get the download URL
      String downloadUrl = await userRepository.uploadProfileImage(filePath);

      // Add the new image to the photos list
      newPhotos.add(downloadUrl);
      user.value.profilePictures = newPhotos;
      user.refresh();

      TLoaders.successSnackBar(
        title: 'Upload Successful',
        message: 'Face similarity: $similarity%. Photo uploaded successfully.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Upload Failed',
        message: 'Failed to upload image: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }

  /// Download verification image to temporary file
  Future<File?> _downloadVerificationImage() async {
    try {
      final response =
          await http.get(Uri.parse(user.value.identityVerificationFaceImage));

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/verification_face.jpg');
        await tempFile.writeAsBytes(response.bodyBytes);
        return tempFile;
      }
      return null;
    } catch (e) {
      print('Error downloading verification image: $e');
      return null;
    }
  }

  void clearUserData() {
    user.value = UserModel.empty();
    profileLoading.value = false;
    // Clear photos list
    newPhotos.clear();
  }
}
