part of 'widget_imports.dart';

class TInfoSection extends StatelessWidget {
  final String content;
  final int index;

  const TInfoSection({super.key,
    required this.content,
    required this.index,
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
                Text(
                    content,
                    style:
                        Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white)),
                const SizedBox(width: 10),

                // Age
                const Text('20', style: TextStyle(fontSize: 25, color: TColors.white)),
              ],
            ),

            // Icon Detail Information
            IconButton(
              onPressed: () {
                pushScreen(
                  context,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                  withNavBar: false,
                  screen: THomeDetailInformation(index),
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
