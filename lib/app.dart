import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding_imports.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
