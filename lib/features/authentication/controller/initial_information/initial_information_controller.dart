import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/features/authentication/screens/%20initial_information/initial_information_imports.dart';
import 'package:ve_amor_app/utils/helpers/network_manager.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';

class InitialInformationController extends GetxController {
  static InitialInformationController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final userName = TextEditingController();
  final dateOfBirth = TextEditingController();
  GlobalKey<FormState> updateUserInformationFormKey = GlobalKey<FormState>();

  // Temporary Model To Save information
  Map<String, dynamic> userTempData = {};

  // The Function Stores A Temporary Name
  void saveName() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['Username'] = userName.text.trim();
    }
  }

  // The Function Stores A Temporary Birthday
  void saveBirthday() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['Username'] = userName.text.trim();
    }
  }

  // The Function Stores A Temporary Gender
  void saveGender() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['Gender'] = userName.text.trim();
    }
  }

  // Update Name
  Future<void> updateName() async {
    try {
      // Check Internet Connectivity
      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        return;
      }

      // Form Validator
      if (!updateUserInformationFormKey.currentState!.validate()) {
        return;
      }

      // Update user's first name & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'Username': userName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      Get.to(() => const InitialBirthdayPage());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update DateOfBirth
  // Future<void> updateName() async {
  //   try {
  //     // Check Internet Connectivity
  //     final isConnect = await NetworkManager.instance.isConnected();
  //     if (!isConnect) {
  //       return;
  //     }
  //
  //     // Form Validator
  //     if (!updateUserNameFormKey.currentState!.validate()) {
  //       return;
  //     }
  //
  //     // Update user's first name & last name in the Firebase Firestore
  //     Map<String, dynamic> name = {
  //       'Username': userName.text.trim(),
  //     };
  //     await userRepository.updateSingleField(name);
  //
  //     Get.to(() => const InitialBirthdayPage());
  //   } catch (e) {
  //     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }
}
