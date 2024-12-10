import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/profile/profile_imports.dart';
import '../user_controller.dart';

class UpdatePreferencesController extends GetxController {
  static UpdatePreferencesController get instance => Get.find();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  // Observable variables
  final selectedWantSeeing = ''.obs;
  final selectedFindingRelationship = ''.obs;

  @override
  void onInit() {
    initializePreferencesData();
    super.onInit();
  }

  // Initialize data from current user
  void initializePreferencesData() {
    selectedWantSeeing.value = userController.user.value.wantSeeing;
    selectedFindingRelationship.value = userController.user.value.findingRelationship;
  }

  // Update want seeing
  Future<void> updateWantSeeing() async {
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
      Map<String, dynamic> update = {'WantSeeing': selectedWantSeeing.value};
      await userRepository.updateSingleField(update);

      // Update local user data
      userController.user.value.wantSeeing = selectedWantSeeing.value;

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your preference has been updated',
      );

      Get.back(); // Close bottom sheet
      Get.off(() => const ProfileScreen()); // Refresh profile screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update finding relationship
  Future<void> updateFindingRelationship() async {
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
      Map<String, dynamic> update = {'FindingRelationship': selectedFindingRelationship.value};
      await userRepository.updateSingleField(update);

      // Update local user data
      userController.user.value.findingRelationship = selectedFindingRelationship.value;

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your relationship preference has been updated',
      );

      Get.back();
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
