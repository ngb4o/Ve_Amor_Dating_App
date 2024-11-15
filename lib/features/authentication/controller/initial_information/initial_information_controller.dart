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
  final selectedGender = ''.obs;
  final selectWantSeeing = ''.obs;
  final newPhotos = <String>[].obs;
  GlobalKey<FormState> updateUserInformationFormKey = GlobalKey<FormState>();

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
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['Username'] = userName.text.trim();
    }
  }

  // The Function Stores A Temporary Birthday
  void saveBirthday() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['DateOfBirth'] = userName.text.trim();
    }
  }

  // The Function Stores A Temporary Gender
  void saveGender() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['Gender'] = selectedGender;
    }
  }

  // The Function Stores A Temporary Gender
  void saveWantSeeing() {
    if (updateUserInformationFormKey.currentState!.validate()) {
      userTempData['WantSeeing'] = selectWantSeeing;
    }
  }

  // Update Name
  Future<void> updateInitialInformation() async {
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
