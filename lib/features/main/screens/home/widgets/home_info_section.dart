part of 'widget_imports.dart';

class TInfoSection extends StatelessWidget {
  final int index;
  final String image;

  const TInfoSection({
    super.key,
    required this.index,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name and Age
            Expanded(
              child: Row(
                children: [
                  // Name
                  Flexible(
                    child: Text(
                      controller.allUsers[index].username,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: TColors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Age
                  Text(
                    controller.allUsers[index].age.toString(),
                    style: const TextStyle(fontSize: 25, color: TColors.white),
                  ),
                ],
              ),
            ),

            // Icon Detail Information
            IconButton(
              onPressed: () {
                pushScreen(
                  context,
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  withNavBar: false,
                  screen: THomeDetailInformation(index),
                );
              },
              icon: const Icon(
                CupertinoIcons.info_circle_fill,
                color: TColors.white,
                size: 25,
              ),
            )
          ],
        ),

        // Location
        Row(
          children: [
            const Icon(Iconsax.location, color: TColors.white, size: 16),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '${controller.allUsers[index].location?['address'] ?? ''} • ${controller.allUsers[index].getFormattedDistance(controller.currentUserLocation.value)}',
                style: const TextStyle(
                  color: TColors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
