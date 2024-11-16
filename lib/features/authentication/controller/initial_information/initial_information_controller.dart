import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/features/authentication/screens/%20initial_information/initial_information_imports.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/navigation_menu.dart';
import 'package:ve_amor_app/utils/helpers/network_manager.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/utils/validators/validation.dart';

class InitialInformationController extends GetxController {
  static InitialInformationController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final userName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final selectedGender = ''.obs;
  final selectWantSeeing = ''.obs;
  final newPhotos = <String>[].obs;

  // Temporary Model To Save information
  Map<String, dynamic> userTempData = {};

  // Update Gender
  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  // Update WantSeeing
  void updateWantSeeing(String wantSeeing) {
    selectWantSeeing.value = wantSeeing;
  }

  // Pictures
  // -- Add Picture
  void addPhotos(List<String> photos) {
    newPhotos.addAll(photos);
  }

  // -- Remove Picture
  void removePhoto(int index) {
    newPhotos.removeAt(index);
  }

  // The Function Stores A Temporary Name
  void saveName() {
    // Validate name
    String? validationError = TValidator.validateEmptyText('Name', userName.text.trim());

    if (validationError != null) {
      TLoaders.errorSnackBar(
        title: 'Name not entered',
        message: validationError,
      );
      return;
    }

    // If validation is passed, save name and navigate to the next page
    userTempData['Username'] = userName.text.trim();
    Get.to(() => const InitialBirthdayPage());
  }

  // The Function Stores A Temporary Birthday
  void saveBirthday() {
    // Validate birthday
    String? validationError = TValidator.validateBirthday(dateOfBirth.text.trim());

    if (validationError != null) {
      TLoaders.errorSnackBar(
        title: 'Invalid Birthday',
        message: validationError,
      );
      return;
    }

    // If validation is passed, save birthday and navigate to the next page
    userTempData['DateOfBirth'] = dateOfBirth.text.trim();
    Get.to(() => const InitialGenderPage());
  }

  // The Function Stores A Temporary Gender
  void saveGender() {
    if (selectedGender.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Gender not selected',
        message: 'Please select a gender before proceeding!',
      );
      return;
    }
    userTempData['Gender'] = selectedGender.value;
    Get.to(() => const InitialInterestedPage());
  }

  // The Function Stores A Temporary Gender
  void saveWantSeeing() {
    if (selectWantSeeing.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Who are you interested in seeing is not selected',
        message: 'Please select interested in seeing before proceeding!',
      );
      return;
    }
    userTempData['WantSeeing'] = selectWantSeeing.value;
    Get.to(() => const InitialRecentPicturePage());
  }

  // The Function Stores A Temporary List of Photos
  Future<void> saveImages() async {
    try {
      if (newPhotos.isNotEmpty) {
        // Upload all images to Firebase Storage
        List<String> uploadedUrls = await userRepository.uploadImages(newPhotos);

        // Save the URLs in the temporary user data map
        userTempData['ProfilePictures'] = uploadedUrls;
      }
    } catch (e) {
      // Handle the exception
      TLoaders.errorSnackBar(title: 'Upload Failed', message: e.toString());
    }
  }

  // Update Initial Information
  Future<void> updateInitialInformation() async {
    try {

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', Assets.animations141594AnimationOfDocer);

      // Check Internet Connectivity
      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save user name
      saveName();

      // Save birthday
      saveBirthday();

      // Save gender
      saveGender();

      // Save wantSeeing
      saveWantSeeing();

      // Save images
      await saveImages();

      // Update user data in Firebase Firestore
      await userRepository.updateSingleField(userTempData);

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your information base has been saved',
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Move To NavigationMenu
      Get.to(() => const NavigationMenu());
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Some Generic Error To The User
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
