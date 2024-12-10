import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/data/services/amazon/aws_compare_face.dart';
import 'package:ve_amor_app/features/authentication/screens/%20initial_information/initial_information_imports.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/navigation_menu.dart';
import 'package:ve_amor_app/utils/helpers/network_manager.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/utils/validators/validation.dart';

import '../../../../data/services/encryption/encryption_service.dart';
import 'package:ve_amor_app/data/services/location/location_service.dart';

import '../../models/location_model.dart';

class InitialInformationController extends GetxController {
  static InitialInformationController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final userName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final selectedGender = ''.obs;
  final selectedWantSeeing = ''.obs;
  final selectedFindingRelationship = ''.obs;
  var scannedCode = ''.obs;
  final faceImage = Rxn<String>();
  final newPhotos = <String>[].obs;
  final questionAnswers = <String, List<String>>{}.obs;
  final _encryptionService = EncryptionService();

  // Temporary Model To Save information
  Map<String, dynamic> userTempData = {};

  // Add new variables for location
  final currentLocation = Rxn<LocationInfo>();

  // Update Gender
  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  // Update WantSeeing
  void updateWantSeeing(String wantSeeing) {
    selectedWantSeeing.value = wantSeeing;
  }

  // Function to update the scanned QR code
  void updateScannedCode(String code) {
    // Split the string by '|' and take the first part
    final identityNumber = code.split('|').first;
    scannedCode.value = identityNumber;
  }

  // Update Relationship
  void updateFindingRelationship(String relationship) {
    selectedFindingRelationship.value = relationship;
  }

  // Pictures
  Future<void> addPhotos(List<String> photos) async {
    for (String photo in photos) {
      if (faceImage.value == null) {
        TLoaders.errorSnackBar(
          title: 'Verification Required',
          message: 'Please complete face verification first.',
        );
        return;
      }

      TFullScreenLoader.openLoadingDialog(
        'Comparing your photo with face...',
        Assets.animations141594AnimationOfDocer,
      );

      final result = await AWSService.compareFaceWithImage(
        faceImage.value!,
        photo,
      );

      TFullScreenLoader.stopLoading();

      if (result.containsKey('error')) {
        TLoaders.errorSnackBar(
          title: 'Face Verification Error',
          message: result['error'],
        );
        return;
      }

      final similarity = result['similarity'].toStringAsFixed(1);

      if (result['isMatch']) {
        TLoaders.successSnackBar(
          title: 'Face Verification Successful',
          message: 'Face similarity: $similarity%. Photo added successfully.',
        );
        newPhotos.add(photo);
      } else {
        TLoaders.errorSnackBar(
          title: 'Face Verification Failed',
          message:
              'Face similarity: $similarity%. Must be at least 95% similar to your verification photo.',
        );
        return;
      }
    }
  }

  // -- Remove Picture
  void removePhoto(int index) {
    newPhotos.removeAt(index);
  }

  // If selected more options
  void toggleLifestyleOption(String questionKey, String option) {
    final currentOptions = questionAnswers[questionKey] ?? [];
    if (currentOptions.contains(option)) {
      currentOptions.remove(option);
    } else {
      currentOptions.add(option);
    }
    questionAnswers[questionKey] = currentOptions;
  }

  // If selected only one option
  void clearAndAddSingleOption(String questionKey, String option) {
    questionAnswers[questionKey] = [option];
  }

  // The Function Stores A Temporary Name
  void saveName() {
    // Validate name
    String? validationError =
        TValidator.validateEmptyText('Name', userName.text.trim());

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
    String? validationError =
        TValidator.validateBirthday(dateOfBirth.text.trim());

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
    if (selectedWantSeeing.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Who are you interested in seeing is not selected',
        message: 'Please select interested in seeing before proceeding!',
      );
      return;
    }
    userTempData['WantSeeing'] = selectedWantSeeing.value;
    Get.to(() => const InitialFindingRelationshipPage());
  }

  // The Function Stores A Temporary Finding Relationship
  void saveFindingRelationship() {
    if (selectedFindingRelationship.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Relationship preference not selected',
        message: 'Please select a relationship preference before proceeding!',
      );
      return;
    }
    userTempData['FindingRelationship'] = selectedFindingRelationship.value;
    Get.to(() => const InitialLifestylePage());
  }

  // The Function Stores A Temporary Lifestyle
  void saveLifestyle() {
    // Get values from questionAnswers
    final zodiac = questionAnswers['Zodiac']?.firstOrNull;
    final sports = questionAnswers['Sports'];
    final pets = questionAnswers['Pets'];

    // Validate zodiac
    if (zodiac == null || zodiac.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Zodiac Required',
        message: 'Please select your zodiac sign before proceeding!',
      );
      return;
    }

    // Validate sports
    if (sports == null || sports.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Sports Required',
        message: 'Please select at least one sport you like!',
      );
      return;
    }

    // Validate pets
    if (pets == null || pets.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Pets Required',
        message: 'Please select at least one option about pets!',
      );
      return;
    }

    // If all validations pass, store in temporary data
    userTempData['Zodiac'] = zodiac;
    userTempData['Sports'] = sports;
    userTempData['Pets'] = pets;

    // Navigate to next screen
    Get.to(() => const InitialLocationPage());
  }

  // Update location info
  void updateLocation(LocationInfo locationInfo) {
    currentLocation.value = locationInfo;
  }

  // Save location to temporary data and navigate
  void saveLocation() {
    if (currentLocation.value == null) {
      TLoaders.errorSnackBar(
        title: 'Location Required',
        message: 'Please enable location services and try again.',
      );
      return;
    }

    // Save location data
    userTempData['Location'] = currentLocation.value!.toJson();

    // Navigate to next screen (e.g., QR verification)
    Get.to(() => InitialIdentityVerificationQRCode());
  }

  // The Function Stores A Temporary Identity Verification Code
  Future<void> saveIdentityVerificationQRCode() async {
    try {
      if (scannedCode.value.isEmpty || scannedCode.value.length < 12) {
        TLoaders.errorSnackBar(
          title: 'QR Code not scanned',
          message:
              'Please scan your identity verification QR code before proceeding!',
        );
        return;
      }

      // Show loading
      TFullScreenLoader.openLoadingDialog(
        'Verifying identity number...',
        Assets.animations141594AnimationOfDocer,
      );

      // Encrypt the identity number before checking existence
      final encryptedIdentityNumber =
          _encryptionService.encryptData(scannedCode.value);

      // Check if identity number exists
      final isExists =
          await userRepository.isIdentityNumberExists(encryptedIdentityNumber);

      // Remove loader
      TFullScreenLoader.stopLoading();

      if (isExists) {
        TLoaders.errorSnackBar(
          title: 'Identity Number Already Exists',
          message: 'This identity number is already registered in our system.',
        );
        return;
      }

      userTempData['IdentityVerificationQR'] = encryptedIdentityNumber;
      print(
          '--------------------------------------------- $encryptedIdentityNumber');
      Get.to(() => const InitialIdentityVerificationFace());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  // The Function Stores A Temporary Identity Verification Face
  Future<void> saveFaceImage(String imagePath) async {
    try {
      if (imagePath.isEmpty) {
        TLoaders.errorSnackBar(
          title: 'Image not captured',
          message: 'Please take a photo before proceeding!',
        );
        return;
      }

      // Show loading dialog
      TFullScreenLoader.openLoadingDialog(
        'Uploading your photo...',
        Assets.animations141594AnimationOfDocer,
      );

      // Upload ảnh và lấy URL sử dụng uploadProfileImage
      String uploadedUrl = await userRepository.uploadFaceImage(imagePath);

      faceImage.value = imagePath;
      userTempData['IdentityVerificationFaceImage'] = uploadedUrl;

      // Remove loader
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Face Uploaded Success',
        message: 'The photo has been saved for account verification.',
      );
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Upload Failed',
        message: e.toString(),
      );
    }
  }

  // The Function Stores A Temporary List of Photos
  Future<void> saveImages() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        Assets.animations141594AnimationOfDocer,
      );

      List<String> uploadedUrls = await userRepository.uploadImages(newPhotos);

      userTempData['ProfilePictures'] = uploadedUrls;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Upload Failed', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  // Update Initial Information
  Future<void> updateInitialInformation() async {
    try {
      // Check Internet Connectivity
      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

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
