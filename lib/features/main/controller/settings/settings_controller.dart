import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ve_amor_app/data/repositories/user/user_repository.dart';
import 'package:ve_amor_app/data/services/location/location_service.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/utils/theme/theme.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();

  final isDarkMode = false.obs;
  final deviceStorage = GetStorage();
  final userRepository = Get.put(UserRepository());
  final locationService = LocationService();
  final currentLocation = Rxn<LocationInfo>();

  @override
  void onInit() {
    loadDarkModePreference();
    super.onInit();
  }

  // Chuyển đổi chế độ và lưu trạng thái
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(value ? TAppTheme.darkTheme : TAppTheme.lightTheme);
    saveDarkModePreference(value);
  }

  // Lưu trạng thái Dark Mode vào GetStorage
  void saveDarkModePreference(bool value) {
    deviceStorage.write('isDarkMode', value);
  }

  // Đọc trạng thái Dark Mode từ GetStorage
  void loadDarkModePreference() {
    isDarkMode.value = deviceStorage.read<bool>('isDarkMode') ?? false;
    Get.changeTheme(isDarkMode.value ? TAppTheme.darkTheme : TAppTheme.lightTheme);
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
