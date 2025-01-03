import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/data/services/location/location_service.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/utils/theme/theme.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/models/location_model.dart';
import '../../../personalization/controller/user_controller.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();

  final themeMode = Rx<ThemeMode>(ThemeMode.system);
  final deviceStorage = GetStorage();
  final userRepository = Get.put(UserRepository());
  final locationService = LocationService();
  final currentLocation = Rxn<LocationInfo>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    loadThemePreference();
    super.onInit();
  }

  // Cập nhật phương thức lưu theme
  void updateTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    saveThemePreference(mode);
  }

  // Lưu preference
  void saveThemePreference(ThemeMode mode) {
    String themeModeString = mode.toString().split('.').last;
    deviceStorage.write('themeMode', themeModeString);
  }

  // Load preference
  void loadThemePreference() {
    String? savedTheme = deviceStorage.read('themeMode');
    if (savedTheme != null) {
      ThemeMode mode = ThemeMode.values.firstWhere(
        (e) => e.toString() == 'ThemeMode.$savedTheme',
        orElse: () => ThemeMode.system,
      );
      themeMode.value = mode;
      Get.changeThemeMode(mode);
    }
  }

  // Hiện dialog xác nhận cập nhật vị trí
  void showLocationUpdateConfirmation() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Update Location',
      middleText: 'Are you sure you want to update your current location? '
          'This will replace your previous location information.',
      confirm: ElevatedButton(
        onPressed: () {
          Get.back(); // Đóng dialog
          updateLocation(); // Thực hiện cập nhật vị trí
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          side: const BorderSide(color: TColors.primary),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Update'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  // Cập nhật vị trí
  Future<void> updateLocation() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Getting your location...',
        Assets.animations141594AnimationOfDocer,
      );

      final locationInfo = await locationService.getCurrentLocationInfo();

      if (locationInfo != null) {
        // Cập nhật vị trí trong controller
        currentLocation.value = locationInfo;

        // Lưu vị trí vào Firebase
        await userRepository.updateSingleField({
          'Location': locationInfo.toJson(),
        });

        userController.user.value.location?['address'] = locationInfo.address;

        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Location Updated',
          message: 'Your location has been successfully updated',
        );
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Location Error',
          message: 'Could not get your location. Please check your settings and try again.',
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Update Failed',
        message: e.toString(),
      );
    }
  }
}
