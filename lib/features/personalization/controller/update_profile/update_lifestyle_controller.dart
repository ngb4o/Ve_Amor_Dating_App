import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/profile/profile_imports.dart';
import '../user_controller.dart';

class UpdateLifestyleController extends GetxController {
  static UpdateLifestyleController get instance => Get.find();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  // Observable variables for selected values
  final selectedZodiac = ''.obs;
  final selectedSports = <String>[].obs;
  final selectedPets = <String>[].obs;

  @override
  void onInit() {
    initializeLifestyleData();
    super.onInit();
  }

  // Initialize data from current user
  void initializeLifestyleData() {
    selectedZodiac.value = userController.user.value.zodiac;
    selectedSports.value = List<String>.from(userController.user.value.sports);
    selectedPets.value = List<String>.from(userController.user.value.pets);
  }

  // Update zodiac
  Future<void> updateZodiac() async {
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
      Map<String, dynamic> update = {'Zodiac': selectedZodiac.value};
      await userRepository.updateSingleField(update);

      // Update local user data
      userController.user.value.zodiac = selectedZodiac.value;

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your zodiac has been updated',
      );

      Get.back(); // Close bottom sheet
      Get.off(() => const ProfileScreen()); // Refresh profile screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update sports
  Future<void> updateSports() async {
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
      Map<String, dynamic> update = {'Sports': selectedSports};
      await userRepository.updateSingleField(update);

      // Update local user data
      userController.user.value.sports = selectedSports;

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your sports preferences have been updated',
      );

      Get.back(); // Close bottom sheet
      Get.off(() => const ProfileScreen()); // Refresh profile screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update pets
  Future<void> updatePets() async {
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
      Map<String, dynamic> update = {'Pets': selectedPets};
      await userRepository.updateSingleField(update);

      // Update local user data
      userController.user.value.pets = selectedPets;

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your pets preferences have been updated',
      );

      Get.back(); // Close bottom sheet
      Get.off(() => const ProfileScreen()); // Refresh profile screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Toggle selection for multi-select options (sports and pets)
  void toggleSelection(String value, RxList<String> list) {
    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }
  }
}
