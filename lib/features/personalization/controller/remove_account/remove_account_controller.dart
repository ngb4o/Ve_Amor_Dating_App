import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/screens/login/login_imports.dart';
import '../../screens/profile/remove_account/remove_account_imports.dart';

class RemoveAccountController extends GetxController {
  static RemoveAccountController get instance => Get.find();

  // Reactive variables
  final hidePassword = true.obs;

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  // Form key for re-authentication
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // Delete user account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', Assets.animations141594AnimationOfDocer);
      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();

          // Stop loading
          TFullScreenLoader.stopLoading();

          // Show message success
          TLoaders.successSnackBar(
            title: 'Account Deleted',
            message: 'Your account has been successfully deleted. '
                'We\'re sad to see you go, but we wish you all the best in your future endeavors.',
            duration: 5,
          );

          // Redirect
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const RemoveAccountScreen());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Re-Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', Assets.animations141594AnimationOfDocer);

      // Check Internet Connectivity
      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validator
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show message success
      TLoaders.successSnackBar(
        title: 'Account Deleted',
        message: 'Your account has been successfully deleted. '
            'We\'re sad to see you go, but we wish you all the best in your future endeavors.',
        duration: 5,
      );

      // Redirect
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
