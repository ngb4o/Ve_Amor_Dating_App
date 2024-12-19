part of 'explore_imports.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> relationshipTypes = [
      {
        'color': TColors.primary,
        'icon': Icons.favorite,
        'text': 'Lover',
        'findingRelationship': 'Lover'
      },
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
                  const TExploreCard(
                    color: TColors.primary,
                    icon: Iconsax.heart5,
                    text: 'Lover',
                    findingRelationship: 'Lover',
                    paddingCard: true,
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
