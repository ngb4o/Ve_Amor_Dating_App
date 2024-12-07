part of 'widget_imports.dart';

class HomeFilterScreen extends StatelessWidget {
  const HomeFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Scaffold(
      appBar: TAppbar(
        title: Text('Search Settings'),
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
                  style: Theme.of(context).textTheme.titleSmall,
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

            Divider(),

            // Gender Preference
            TSettingsMenuTile(
              title: 'Interested in the profile of',
              subtitle: 'Tap to chose gender',
              icon: Iconsax.favorite_chart,
              onTap: () {

              },
            ),

            Divider(),


            // Age Range
            Text(
              'Age',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Obx(() => Column(
                  children: [
                    RangeSlider(
                      values: controller.ageRange.value,
                      min: 18,
                      max: 100,
                      onChanged: controller.updateAgeRange,
                      activeColor: TColors.primary,
                    ),
                    Text(
                        '${controller.ageRange.value.start.toInt()}-${controller.ageRange.value.end.toInt()}'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
