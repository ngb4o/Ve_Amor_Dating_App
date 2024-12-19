part of 'initial_information_imports.dart';

class InitialLocationPage extends StatelessWidget {
  const InitialLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InitialInformationController.instance;
    final locationService = LocationService();

    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Your Location',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Sub Title
            Text(
              'Please enable location services to help us find potential matches near you.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Location Button using TSettingsMenuTile
            TSettingsMenuTile(
              icon: Iconsax.location,
              title: 'Get Location',
              subtitle: 'Tap to get your current location',
              onTap: () async {
                final locationInfo =
                    await locationService.getCurrentLocationInfo();
                if (locationInfo != null) {
                  controller.updateLocation(locationInfo);
                }
              },
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Display location info
            Obx(() => controller.currentLocation.value != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Your Current Location:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      Text(
                        controller.currentLocation.value?.address ??
                            'Address not found',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : const SizedBox.shrink()),

            const Spacer(),

            // Next Button - Only show when location is captured
            Obx(() => controller.currentLocation.value != null
                ? TBottomButton(
                    onPressed: () {
                      controller.saveLocation();
                    },
                    textButton: 'Next',
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
