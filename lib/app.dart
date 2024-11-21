import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/bindings/general_bindings.dart';
import 'package:ve_amor_app/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding_imports.dart';
import 'features/main/controller/settings/settings_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: settingController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialBinding: GeneralBindings(),
      home: const OnBoardingScreen(),
    ));
  }
}

