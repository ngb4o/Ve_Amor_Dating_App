part of 'widget_imports.dart';

class HomeFilterScreen extends StatelessWidget {
  const HomeFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: const Text('Search Settings'),
        isCenterTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              controller.fetchAllUsers(); // Refresh users with new filters
              Get.back();
            },
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.primary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Distance Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Maximum distance',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Obx(() => Text('${controller.maxDistance.value.toInt()} km')),
              ],
            ),
            Obx(
              () => Slider(
                value: controller.maxDistance.value,
                min: 0,
                max: 100,
                onChanged: controller.updateMaxDistance,
                activeColor: TColors.primary,
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Gender Preference
            TSettingsMenuTile(
              title: 'Interested in',
              subtitle: 'Tap to chose gender',
              icon: Iconsax.favorite_chart,
              onTap: () {},
              trailing: Text(
                'Women',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Age Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Obx(
                  () => Text(
                      '${controller.ageRange.value.start.toInt()}-${controller.ageRange.value.end.toInt()}'),
                ),
              ],
            ),
            Obx(
              () => RangeSlider(
                values: controller.ageRange.value,
                min: 18,
                max: 100,
                onChanged: controller.updateAgeRange,
                activeColor: TColors.primary,
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Looking for
            TSettingsMenuTile(
              title: 'Looking for',
              subtitle: 'Tap to choose',
              icon: Iconsax.search_favorite,
              trailing: const Icon(Iconsax.arrow_right_34, size: 23),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header bar indicator
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: TSizes.md),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                      ),

                      // Title
                      Text(
                        'Looking for',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Options with more spacing and padding
                      const Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          TFilterChip(label: 'Lover'),
                          TFilterChip(label: 'A long-term dating partner'),
                          TFilterChip(label: 'Anything that might happen'),
                          TFilterChip(label: 'A casual relationship'),
                          TFilterChip(label: 'New friends'),
                          TFilterChip(label: 'I’m not sure yet'),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Done button
                      TBottomButton(
                        onPressed: () {},
                        textButton: 'Done',
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                ),
                isScrollControlled: true,
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Zodiac
            TSettingsMenuTile(
              title: 'Zodiac',
              subtitle: 'Tap to chose',
              icon: Icons.ac_unit,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header bar indicator
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: TSizes.md),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                      ),

                      // Title
                      Text(
                        'Zodiac',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Zodiac options
                      Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          for (var zodiac in LifestyleOptions.zodiacOptions) TFilterChip(label: zodiac),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Done button
                      TBottomButton(
                        onPressed: () => Get.back(),
                        textButton: 'Done',
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                ),
                isScrollControlled: true,
              ),
              trailing: const Icon(Iconsax.arrow_right_34, size: 23),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Pets
            TSettingsMenuTile(
              title: 'Pets',
              subtitle: 'Tap to chose',
              icon: Iconsax.pet,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header bar indicator
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: TSizes.md),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                      ),

                      // Title
                      Text(
                        'Pets',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Pet options
                      Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          for (var pet in LifestyleOptions.petsOptions) TFilterChip(label: pet),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Done button
                      TBottomButton(
                        onPressed: () => Get.back(),
                        textButton: 'Done',
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                ),
                isScrollControlled: true,
              ),
              trailing: const Icon(Iconsax.arrow_right_34, size: 23),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Pets
            TSettingsMenuTile(
              title: 'Sports',
              subtitle: 'Tap to chose',
              icon: Icons.sports_cricket_outlined,
              trailing: const Icon(Iconsax.arrow_right_34, size: 23),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header bar indicator
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: TSizes.md),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(TSizes.xs),
                        ),
                      ),

                      // Title
                      Text(
                        'Sports',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Pet options
                      Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          for (var sport in LifestyleOptions.sportsOptions) TFilterChip(label: sport),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Done button
                      TBottomButton(
                        onPressed: () => Get.back(),
                        textButton: 'Done',
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                ),
                isScrollControlled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
