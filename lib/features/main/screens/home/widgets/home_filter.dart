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
            onPressed: () => controller.resetFilters(),
            child: Text('Reset', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              controller.fetchAllUsers();
              Get.back();
            },
            child:
                Text('Done', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.primary)),
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
                Text('Maximum distance', style: Theme.of(context).textTheme.bodyLarge),
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

            const SizedBox(height: TSizes.spaceBtwItems),

            // Age Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Age', style: Theme.of(context).textTheme.bodyLarge),
                Obx(() => Text(
                    '${controller.ageRange.value.start.toInt()}-${controller.ageRange.value.end.toInt()}')),
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

            // Gender Preference
            TSettingsMenuTile(
              title: 'Interested in',
              subtitle: controller.genderPreference.value.isEmpty
                  ? 'Tap to choose'
                  : controller.genderPreference.value,
              icon: Iconsax.heart,
              onTap: () => Get.bottomSheet(
                _buildBottomSheet(
                  context: context,
                  title: 'Interested in',
                  child: Obx(
                    () => Wrap(
                      spacing: TSizes.xs,
                      children: LifestyleOptions.interestedInOptions.map((gender) {
                        return TFilterChip(
                          label: gender,
                          selected: controller.genderPreference.value == gender,
                          onSelected: (_) => controller.setGenderPreference(gender),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Looking for
            TSettingsMenuTile(
              title: 'Looking for',
              subtitle: controller.selectedLookingFor.value.isEmpty
                  ? 'Tap to choose'
                  : controller.selectedLookingFor.value,
              icon: Iconsax.search_favorite,
              onTap: () => Get.bottomSheet(
                _buildBottomSheet(
                  context: context,
                  title: 'Looking for',
                  child: Obx(
                    () => Wrap(
                      spacing: TSizes.xs,
                      children: LifestyleOptions.lookingForOptions.map((option) {
                        return TFilterChip(
                          label: option,
                          selected: controller.selectedLookingFor.value == option,
                          onSelected: (_) => controller.setLookingFor(option),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Zodiac
            TSettingsMenuTile(
              title: 'Zodiac',
              subtitle:
                  controller.selectedZodiac.value.isEmpty ? 'Tap to choose' : controller.selectedZodiac.value,
              icon: Icons.ac_unit,
              onTap: () => Get.bottomSheet(
                _buildBottomSheet(
                  context: context,
                  title: 'Zodiac',
                  child: Obx(
                    () => Wrap(
                      spacing: TSizes.xs,
                      children: LifestyleOptions.zodiacOptions.map((zodiac) {
                        return TFilterChip(
                          label: zodiac,
                          selected: controller.selectedZodiac.value == zodiac,
                          onSelected: (_) => controller.toggleZodiac(zodiac),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Sports
            TSettingsMenuTile(
              title: 'Sports',
              subtitle:
                  controller.selectedSports.isEmpty ? 'Tap to choose' : controller.selectedSports.join(', '),
              icon: Icons.sports_cricket,
              onTap: () => Get.bottomSheet(
                _buildBottomSheet(
                  context: context,
                  title: 'Sports',
                  child: Obx(
                    () => Wrap(
                      spacing: TSizes.xs,
                      children: LifestyleOptions.sportsOptions.map((sport) {
                        return TFilterChip(
                          label: sport,
                          selected: controller.selectedSports.contains(sport),
                          onSelected: (_) => controller.toggleSport(sport),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: TSizes.xs),
            const Divider(),
            const SizedBox(height: TSizes.xs),

            // Pets
            TSettingsMenuTile(
              title: 'Pets',
              subtitle:
                  controller.selectedPets.isEmpty ? 'Tap to choose' : controller.selectedPets.join(', '),
              icon: Iconsax.pet,
              onTap: () => Get.bottomSheet(
                _buildBottomSheet(
                  context: context,
                  title: 'Pets',
                  child: Obx(
                    () => Wrap(
                      spacing: TSizes.xs,
                      children: LifestyleOptions.petsOptions.map((pet) {
                        return TFilterChip(
                          label: pet,
                          selected: controller.selectedPets.contains(pet),
                          onSelected: (_) => controller.togglePet(pet),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.md),
          topRight: Radius.circular(TSizes.md),
        ),
      ),
      child: SingleChildScrollView(
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
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Content
            child,

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
    );
  }
}
