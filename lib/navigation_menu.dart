import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/features/main/screens/message/message_imports.dart';
import 'package:ve_amor_app/features/main/screens/settings/settings_imports.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import 'features/main/screens/home/home_imports.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 85,
          elevation: 0,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: [
            buildNavigationDestination(
              index: 0,
              controller: controller,
              icon: Iconsax.layer5,
              label: 'Home',
            ),
            buildNavigationDestination(
              index: 1,
              controller: controller,
              icon: Iconsax.heart5,
              label: 'Wishlist',
            ),
            buildNavigationDestination(
              index: 2,
              controller: controller,
              icon: Iconsax.message5,
              label: 'Message',
            ),
            buildNavigationDestination(
              index: 3,
              controller: controller,
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  NavigationDestination buildNavigationDestination({
    required int index,
    required NavigationController controller,
    required IconData icon,
    required String label,
  }) {
    return NavigationDestination(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: 70,
            color: controller.selectedIndex.value == index ? TColors.primary : Colors.transparent,
          ),
          const SizedBox(height: 10),
          Icon(
            icon,
            size: 30,
            color: controller.selectedIndex.value == index ? TColors.primary : Colors.grey,
          ),
        ],
      ),
      label: label,
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(color: Colors.red),
    const MessageScreen(),
    const SettingsScreen(),
  ];
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ve_amor_app/utils/constants/colors.dart';
// import 'package:ve_amor_app/utils/helpers/helper_functions.dart';
//
// import 'features/main/screen/home/home_imports.dart';
//
// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     final dark = THelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       bottomNavigationBar: Obx(
//             () => NavigationBar(
//           height: 80,
//           elevation: 0,
//           backgroundColor: dark ? TColors.black : TColors.white,
//           indicatorColor: Colors.transparent,
//           labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) {
//             controller.selectedIndex.value = index;
//           },
//           destinations: [
//             NavigationDestination(
//               icon: Icon(
//                 Iconsax.layer5,
//                 size: 28,
//                 color: controller.selectedIndex.value == 0 ? TColors.primary : Colors.grey,
//               ),
//               label: 'Home',
//             ),
//             NavigationDestination(
//               icon: Icon(
//                 Iconsax.heart5,
//                 size: 28,
//                 color: controller.selectedIndex.value == 1 ? TColors.primary : Colors.grey,
//               ),
//               label: 'Wishlist',
//             ),
//             NavigationDestination(
//               icon: Icon(
//                 Iconsax.message5,
//                 size: 28,
//                 color: controller.selectedIndex.value == 2 ? TColors.primary : Colors.grey,
//               ),
//               label: 'Message',
//             ),
//             NavigationDestination(
//               icon: Icon(
//                 Icons.person,
//                 size: 30,
//                 color: controller.selectedIndex.value == 3 ? TColors.primary : Colors.grey,
//               ),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }
//
// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;
//
//   final screens = [
//     const HomeScreen(),
//     Container(color: Colors.red),
//     Container(color: Colors.yellow),
//     Container(color: Colors.blue),
//   ];
// }
