import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/features/personalization/models/user_model.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';

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
      // Start loading
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      // Populate profile pictures
      newPhotos.addAll(user.profilePictures);
      // Update user object
      this.user(user);
    } catch (e) {
      // Reset user object on error
      user(UserModel.empty());
    } finally {
      // Stop loading
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
          email: user.value.email.isNotEmpty ? user.value.email : userCredentials.user!.email ?? '',
          phoneNumber: user.value.phoneNumber,
          profilePictures: user.value.profilePictures,
          dateOfBirth: user.value.dateOfBirth,
          gender: user.value.gender,
          wantSeeing: user.value.wantSeeing,
          lifeStyle: user.value.lifeStyle,
          identityVerificationQR: user.value.identityVerificationQR,
          identityVerificationFaceImage: user.value.identityVerificationFaceImage,
          findingRelationship: user.value.findingRelationship,
          likes: user.value.likes,
          nopes: user.value.nopes,
          matches: user.value.matches,
        );

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
        message: 'Something went wrong while saving your information. Please try again.',
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
      // Start uploading state
      imageUploading.value = true;

      // Upload the image and get the download URL
      String downloadUrl = await userRepository.uploadProfileImage(filePath);

      // Add the new image to the photos list
      newPhotos.add(downloadUrl);
      user.value.profilePictures = newPhotos;
      user.refresh();

      TLoaders.successSnackBar(
        title: 'Upload Successful',
        message: 'Your image has been uploaded and added to your profile.',
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
}
