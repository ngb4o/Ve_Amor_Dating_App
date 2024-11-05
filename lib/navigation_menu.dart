import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import 'features/main/screen/home/home_imports.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    const primaryColor = TColors.primary;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: dark ? TColors.primary.withOpacity(0.1) : TColors.primary.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.layer5,
                color: controller.selectedIndex.value == 0 ? primaryColor : Colors.grey,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.heart5,
                color: controller.selectedIndex.value == 1 ? primaryColor : Colors.grey,
              ),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.message5,
                color: controller.selectedIndex.value == 2 ? primaryColor : Colors.grey,
              ),
              label: 'Message',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                size: 28,
                color: controller.selectedIndex.value == 3 ? primaryColor : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(color: Colors.red),
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
  ];
}
