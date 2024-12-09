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
                      const Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          TFilterChip(label: 'Aries (Mar 21 - Apr 19)'),
                          TFilterChip(label: 'Taurus (Apr 20 - May 20)'),
                          TFilterChip(label: 'Gemini (May 21 - Jun 20)'),
                          TFilterChip(label: 'Cancer (Jun 21 - Jul 22)'),
                          TFilterChip(label: 'Leo (Jul 23 - Aug 22)'),
                          TFilterChip(label: 'Virgo (Aug 23 - Sep 22)'),
                          TFilterChip(label: 'Libra (Sep 23 - Oct 22)'),
                          TFilterChip(label: 'Scorpio (Oct 23 - Nov 21)'),
                          TFilterChip(label: 'Sagittarius (Nov 22 - Dec 21)'),
                          TFilterChip(label: 'Capricorn (Dec 22 - Jan 19)'),
                          TFilterChip(label: 'Aquarius (Jan 20 - Feb 18)'),
                          TFilterChip(label: 'Pisces (Feb 19 - Mar 20)'),
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
                      const Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          TFilterChip(label: 'Dog'),
                          TFilterChip(label: 'Cat'),
                          TFilterChip(label: 'Fish'),
                          TFilterChip(label: 'Rabbit'),
                          TFilterChip(label: 'Hamster'),
                          TFilterChip(label: 'Turtle'),
                          TFilterChip(label: 'No pets'),
                          TFilterChip(label: 'Allergic to animals'),
                          TFilterChip(label: 'All kinds of pets'),
                          TFilterChip(label: 'Others'),
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
                        'Pets',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Pet options
                      const Wrap(
                        spacing: TSizes.xs,
                        runSpacing: TSizes.xs,
                        children: [
                          TFilterChip(label: 'Pickleball'),
                          TFilterChip(label: 'Paddle Tennis'),
                          TFilterChip(label: 'Esports'),
                          TFilterChip(label: 'Soccer'),
                          TFilterChip(label: 'Basketball'),
                          TFilterChip(label: 'Tennis'),
                          TFilterChip(label: 'Cricket'),
                          TFilterChip(label: 'Golf'),
                          TFilterChip(label: 'Baseball'),
                          TFilterChip(label: 'Running'),
                          TFilterChip(label: 'Cycling'),
                          TFilterChip(label: 'Volleyball'),
                          TFilterChip(label: 'Yoga'),
                          TFilterChip(label: 'Gym'),
                          TFilterChip(label: 'Swimming'),
                          TFilterChip(label: 'Boxing'),
                          TFilterChip(label: 'MMA'),
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
