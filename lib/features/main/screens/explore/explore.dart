part of 'explore_imports.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> relationshipTypes = [
      {
        'color': Colors.pink[300]!,
        'icon': Icons.favorite_border,
        'text': 'Long-term dating',
        'findingRelationship': 'A long-term dating partner'
      },
      {
        'color': Colors.purple[300]!,
        'icon': Icons.emoji_events,
        'text': 'Open to anything',
        'findingRelationship': 'Anything that might happen'
      },
      {
        'color': Colors.orange[300]!,
        'icon': Icons.celebration,
        'text': 'Casual relationship',
        'findingRelationship': 'A casual relationship'
      },
      {
        'color': Colors.blue[300]!,
        'icon': Icons.people,
        'text': 'New friends',
        'findingRelationship': 'New friends'
      },
      {
        'color': Colors.teal[300]!,
        'icon': Icons.question_mark,
        'text': 'Not sure yet',
        'findingRelationship': 'I\'m not sure yet'
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const THomeAppBar(
                showActionButtonAppbar: false, centerAppbar: true),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const TSectionHeading(title: TTexts.titleExplore),
                  const SizedBox(height: TSizes.sm),

                  // Card Lover
                  GestureDetector(
                    onTap: () {
                      final homeController = Get.find<HomeController>();
                      homeController.resetFilters(); // Reset all filters
                      homeController.fetchAllUsers();
                      Get.to(
                        () => const HomeScreen(
                            showBackArrow: true, centerTitle: true),
                        popGesture: true,
                        transition: Transition.rightToLeft,
                      )?.then((_) {
                        // Reset filters when returning
                        homeController.resetFilters();
                        homeController.fetchAllUsers();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: TSizes.xl),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.heart5,
                                color: TColors.white, size: 60),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: TSizes.lg),
                                child: Text(
                                  'Lover',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //
                  const TSectionHeading(title: 'Dating with common goals'),
                  Text('Find people who have common dating goals',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12)),
                  const SizedBox(height: TSizes.sm),

                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: relationshipTypes.length,
                    itemBuilder: (context, index) {
                      final type = relationshipTypes[index];
                      return TExploreCard(
                        color: type['color'],
                        icon: type['icon'],
                        text: type['text'],
                        findingRelationship: type['findingRelationship'],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
