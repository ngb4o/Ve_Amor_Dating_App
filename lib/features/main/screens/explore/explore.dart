part of 'explore_imports.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const THomeAppBar(showActionButtonAppbar: false, centerAppbar: true),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const TSectionHeading(title: TTexts.titleExplore),
                  const SizedBox(height: TSizes.sm),
        
                  // Card Lover
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: TSizes.xl),
                    decoration: BoxDecoration(
                      color:TColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.heart5, color: TColors.white, size: 60),
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
                  const SizedBox(height: TSizes.spaceBtwItems),
        
                  //
                  const TSectionHeading(title: 'Dating with common goals'),
                  Text('Find people who have common dating goals',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)),
                  const SizedBox(height: TSizes.sm),
        
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: 6,
                    // Updated to show more cards
                    itemBuilder: (context, index) {
                      // Define the properties for each card based on the index
                      Color color;
                      IconData icon;
                      String text;
        
                      switch (index) {
                        case 0:
                          color = Colors.purple[300]!;
                          icon = Icons.nightlight_round;
                          text = 'Free tonight';
                          break;
                        case 1:
                          color = Colors.orange[300]!;
                          icon = Icons.star;
                          text = 'No-strings-attached relationship';
                          break;
                        case 2:
                          color = Colors.blue[300]!;
                          icon = Icons.people;
                          text = 'Meet new people';
                          break;
                        case 3:
                          color = Colors.green[300]!;
                          icon = Icons.favorite;
                          text = 'Looking for love';
                          break;
                        case 4:
                          color = Colors.red[300]!;
                          icon = Icons.coffee;
                          text = 'Casual coffee';
                          break;
                        case 5:
                          color = Colors.teal[300]!;
                          icon = Icons.music_note;
                          text = 'Shared music interests';
                          break;
                        default:
                          color = Colors.grey;
                          icon = Icons.help;
                          text = 'Explore';
                          break;
                      }
        
                      return TExploreCard(
                        color: color,
                        icon: icon,
                        text: text,
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
