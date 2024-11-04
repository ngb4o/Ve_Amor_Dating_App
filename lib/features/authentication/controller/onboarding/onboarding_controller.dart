import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/login/login_imports.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current Index When Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump To The Specific Dot Selected Page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update Current Index & Jump To Next Page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      // final storage = GetStorage();

      // storage.write('isFirstTime', false);

      Get.to(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
    int page = currentPageIndex.value + 1;
    pageController.jumpToPage(page);
  }

  // Skip Button
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
