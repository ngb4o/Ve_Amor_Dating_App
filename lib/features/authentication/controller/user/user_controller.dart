import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/features/authentication/models/user_model.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final profileLoading = false.obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record
      await fetchUserRecord();

      if (userCredentials != null) {
        // Map data
        final user = UserModel(
          id: userCredentials.user!.uid,
          username: '',
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePictures: [],
          dateOfBirth: '',
          gender: '',
          wantSeeing: '',
          lifeStyle: [],
          identityVerificationQR: '',
        );

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile',
      );
    }
  }

// Delete user account
// void deleteUserAccount() async {
//   try {
//     TFullScreenLoader.openLoadingDialog('Processing', Assets.animations141594AnimationOfDocer);
//     // First re-authenticate user
//     final auth = AuthenticationRepository.instance;
//     final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
//     if (provider.isNotEmpty) {
//       // Re verify auth email
//       if (provider == 'google.com') {
//         await auth.signInWithGoogle();
//         await auth.deleteAccount();
//
//         // Stop loading
//         TFullScreenLoader.stopLoading();
//
//         // Show message success
//         TLoaders.successSnackBar(
//           title: 'Account Deleted',
//           message: 'Your account has been successfully deleted. '
//               'We\'re sad to see you go, but we wish you all the best in your future endeavors.',
//           duration: 5,
//         );
//
//         // Redirect
//         Get.offAll(() => const LoginScreen());
//       } else if (provider == 'password') {
//         TFullScreenLoader.stopLoading();
//         Get.to(() => const RemoveAccountScreen());
//       }
//     }
//   } catch (e) {
//     TFullScreenLoader.stopLoading();
//     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//   }
// }

// Re-Authenticate before deleting
// Future<void> reAuthenticateEmailAndPasswordUser() async {
//   try {
//     TFullScreenLoader.openLoadingDialog('Processing', Assets.animations141594AnimationOfDocer);
//
//     // Check Internet Connectivity
//     final isConnect = await NetworkManager.instance.isConnected();
//     if (!isConnect) {
//       TFullScreenLoader.stopLoading();
//       return;
//     }
//
//     // Form Validator
//     if (!reAuthFormKey.currentState!.validate()) {
//       TFullScreenLoader.stopLoading();
//       return;
//     }
//
//     await AuthenticationRepository.instance
//         .reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
//     await AuthenticationRepository.instance.deleteAccount();
//
//     // Stop loading
//     TFullScreenLoader.stopLoading();
//
//     // Show message success
//     TLoaders.successSnackBar(
//       title: 'Account Deleted',
//       message: 'Your account has been successfully deleted. '
//           'We\'re sad to see you go, but we wish you all the best in your future endeavors.',
//       duration: 5,
//     );
//
//     // Redirect
//     Get.offAll(() => const LoginScreen());
//   } catch (e) {
//     TFullScreenLoader.stopLoading();
//     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//   }
// }

// Upload Profile Image
// uploadUserProfilePicture() async {
//   try {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 70,
//       maxHeight: 512,
//       maxWidth: 512,
//     );
//     if (image != null) {
//       imageUploading.value = true;
//
//       // Upload image
//       final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);
//
//       // Update user image record
//       Map<String, dynamic> json = {'ProfilePicture': imageUrl};
//       await userRepository.updateSingleField(json);
//
//       user.value.profilePicture = imageUrl;
//       user.refresh();
//
//       TLoaders.successSnackBar(title: 'Congratulations', message: 'Your profile image has been update!');
//     }
//   } catch (e) {
//     TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong: ${e.toString()}');
//   } finally {
//     imageUploading.value = false;
//   }
// }
}
