import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/profile/profile_imports.dart';
import '../user_controller.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  // Form key
  GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();

  // Text Controllers
  final phoneNumberController = TextEditingController();

  // Observable variables for lifestyle
  final selectedZodiac = ''.obs;
  final selectedSports = <String>[].obs;
  final selectedPets = <String>[].obs;

  // Observable variables for preferences
  final selectedWantSeeing = ''.obs;
  final selectedFindingRelationship = ''.obs;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  // Initialize all data
  void initializeData() {
    phoneNumberController.text = userController.user.value.phoneNumber;
    selectedZodiac.value = userController.user.value.zodiac;
    selectedSports.value = List<String>.from(userController.user.value.sports);
    selectedPets.value = List<String>.from(userController.user.value.pets);
    selectedWantSeeing.value = userController.user.value.wantSeeing;
    selectedFindingRelationship.value = userController.user.value.findingRelationship;
  }

  // Generic update function
  Future<void> updateField(String fieldName, dynamic value) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        Assets.animations141594AnimationOfDocer,
      );

      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update in Firebase
      Map<String, dynamic> update = {fieldName: value};
      await userRepository.updateSingleField(update);

      // Update local user data based on field
      switch (fieldName) {
        case 'PhoneNumber':
          userController.user.value.phoneNumber = value;
          break;
        case 'Zodiac':
          userController.user.value.zodiac = value;
          break;
        case 'Sports':
          userController.user.value.sports = value;
          break;
        case 'Pets':
          userController.user.value.pets = value;
          break;
        case 'WantSeeing':
          userController.user.value.wantSeeing = value;
          break;
        case 'FindingRelationship':
          userController.user.value.findingRelationship = value;
          break;
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your information has been updated',
      );

      Get.back();
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Specific update functions
  Future<void> updatePhoneNumber() async {
    if (!updateProfileFormKey.currentState!.validate()) return;
    await updateField('PhoneNumber', phoneNumberController.text.trim());
  }

  Future<void> updateZodiac() async {
    await updateField('Zodiac', selectedZodiac.value);
  }

  Future<void> updateSports() async {
    await updateField('Sports', selectedSports);
  }

  Future<void> updatePets() async {
    await updateField('Pets', selectedPets);
  }

  Future<void> updateWantSeeing() async {
    await updateField('WantSeeing', selectedWantSeeing.value);
  }

  Future<void> updateFindingRelationship() async {
    await updateField('FindingRelationship', selectedFindingRelationship.value);
  }

  // Toggle selection for multi-select options
  void toggleSelection(String value, RxList<String> list) {
    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
