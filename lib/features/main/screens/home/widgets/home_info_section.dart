part of 'widget_imports.dart';

class TInfoSection extends StatelessWidget {
  final String name;
  final int index;
  final String age;
  final String image;
  final int numberOfPhotos;

  const TInfoSection({
    super.key,
    required this.name,
    required this.index,
    required this.age,
    required this.image,
    required this.numberOfPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Name
                Text(name, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white)),
                const SizedBox(width: 10),

                // Age
                Text(age, style: const TextStyle(fontSize: 25, color: TColors.white)),
              ],
            ),

            // Icon Detail Information
            IconButton(
              onPressed: () {
                pushScreen(
                  context,
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  withNavBar: false,
                  screen: THomeDetailInformation(
                    index,
                    image: image,
                    age: age,
                    name: name,
                    numberOfPhoto: numberOfPhotos,
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.info_circle_fill, color: TColors.white, size: 25),
            )
          ],
        ),

        // Location
        const Row(
          children: [
            Icon(Iconsax.location, color: TColors.white, size: 16),
            SizedBox(width: 5),
            Text('Đà Nẵng', style: TextStyle(color: TColors.white)),
          ],
        ),
      ],
    );
  }
}
