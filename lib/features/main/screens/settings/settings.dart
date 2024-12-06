part of 'settings_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  TAppbar(
                    title: Text(
                      'Account',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                    paddingTitle: 0,
                  ),

                  // User Profile Card
                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems,
                  top: TSizes.spaceBtwItems,
                  right: TSizes.spaceBtwItems),
              child: Column(
                children: [
                  // Account Setting
                  const TSectionHeading(title: 'Account Setting'),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  const TSettingsMenuTile(
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    icon: Iconsax.security_card,
                  ),
                  TSettingsMenuTile(
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: true,
                      onChanged: (value) {},
                    ),
                    icon: Iconsax.notification,
                  ),

                  // App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Get Location',
                    subtitle: 'Tap to get your current location',
                    onTap: () => controller.showLocationUpdateConfirmation(),
                  ),
                  TSettingsMenuTile(
                    title: 'Theme',
                    subtitle: 'Choose your preferred theme',
                    icon: Icons.dark_mode_outlined,
                    onTap: () => Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Wrap(
                          children: [
                            // Theme System
                            ListTile(
                              leading: const Icon(
                                Icons.brightness_auto,
                                color: TColors.primary,
                                size: TSizes.lg,
                              ),
                              title: const Text('System',
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                              onTap: () {
                                controller.updateTheme(ThemeMode.system);
                                Get.back();
                              },
                              trailing: Obx(
                                () => controller.themeMode.value == ThemeMode.system
                                    ? const Icon(Icons.check, color: TColors.primary)
                                    : const SizedBox(),
                              ),
                            ),

                            // Theme Light
                            ListTile(
                              leading: const Icon(
                                Icons.light_mode,
                                color: TColors.primary,
                                size: TSizes.lg,
                              ),
                              title: const Text(
                                'Light',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                controller.updateTheme(ThemeMode.light);
                                Get.back();
                              },
                              trailing: Obx(() => controller.themeMode.value == ThemeMode.light
                                  ? const Icon(Icons.check, color: TColors.primary)
                                  : const SizedBox()),
                            ),

                            // Theme Dark
                            ListTile(
                              leading: const Icon(
                                Icons.dark_mode,
                                color: TColors.primary,
                                size: TSizes.lg,
                              ),
                              title:
                                  const Text('Dark', style: TextStyle(fontWeight: FontWeight.w600)),
                              onTap: () {
                                controller.updateTheme(ThemeMode.dark);
                                Get.back();
                              },
                              trailing: Obx(() => controller.themeMode.value == ThemeMode.dark
                                  ? const Icon(Icons.check, color: TColors.primary)
                                  : const SizedBox()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TSettingsMenuTile(
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: true,
                      onChanged: (value) {},
                    ),
                    icon: Iconsax.image,
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.xs),

            // List Upgrade
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    // Specify the subscription type based on your conditions
                    String subscriptionType;
                    if (index == 0) {
                      subscriptionType = 'Plus';
                    } else if (index == 1) {
                      subscriptionType = 'Platinum';
                    } else {
                      subscriptionType = 'Gold';
                    }

                    return SubscriptionCard(subscriptionType: subscriptionType);
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: const Text('Logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
