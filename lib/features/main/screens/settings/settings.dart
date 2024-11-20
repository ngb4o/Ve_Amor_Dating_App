part of 'settings_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
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
                  left: TSizes.defaultSpace, top: TSizes.defaultSpace, right: TSizes.defaultSpace),
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
                  const TSettingsMenuTile(
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    icon: Iconsax.notification,
                  ),

                  // App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: true,
                      onChanged: (value) {},
                    ),
                    icon: Iconsax.location,
                  ),
                  TSettingsMenuTile(
                    title: 'Dark Mode',
                    subtitle: 'Enable dark theme for comfortable night',
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: false,
                      onChanged: (value) {},
                    ),
                    icon: Icons.dark_mode_outlined,
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
