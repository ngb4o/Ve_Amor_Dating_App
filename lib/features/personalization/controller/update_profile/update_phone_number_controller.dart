
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/profile/profile_imports.dart';
import '../user_controller.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumberController = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserPhoneNumberFormKey = GlobalKey<FormState>();

  // Init user data when home screen appear
  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializePhoneNumber() async {
    phoneNumberController.text = userController.user.value.phoneNumber;
  }

  Future<void> updateUserName() async {
    try {
      // Start loader
      TFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        Assets.animations141594AnimationOfDocer,
      );

      // Check Internet Connectivity
      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validator
      if (!updateUserPhoneNumberFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first name & last name in the Firebase Firestore
      Map<String, dynamic> phoneNumber = {
        'PhoneNumber': phoneNumberController.text.trim(),
      };
      await userRepository.updateSingleField(phoneNumber);

      // Update the Rx user value
      userController.user.value.phoneNumber = phoneNumberController.text.trim();

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show success message
      await TLoaders.successSnackBar(title: 'Congratulation', message: 'Your name has been update');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
