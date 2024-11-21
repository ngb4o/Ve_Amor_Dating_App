import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ve_amor_app/utils/theme/theme.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();

  final isDarkMode = false.obs;
  final deviceStorage = GetStorage();

  @override
  void onInit() {
    loadDarkModePreference();
    super.onInit();
  }

  // Chuyển đổi chế độ và lưu trạng thái
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    // Cập nhật theme của ứng dụng
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
    // Đặt theme khi khởi động ứng dụng
    Get.changeTheme(isDarkMode.value ? TAppTheme.darkTheme : TAppTheme.lightTheme);
  }
}
