part of 'widget_imports.dart';

class THomeDetailInformation extends StatelessWidget {
  const THomeDetailInformation(
    this.index, {
    super.key,
    required this.image,
    required this.numberOfPhoto,
    required this.name,
    required this.age,
  });

  final int index;
  final String image;
  final int numberOfPhoto;
  final String name;
  final String age;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = HomeController.instance;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    // Image
                    SizedBox(
                      width: THelperFunctions.screenWidth(),
                      height: THelperFunctions.screenHeight() * 0.6,
                      child: Hero(
                        tag: 'imageTage$index',
                        child: Stack(
                          children: [
                            Obx(
                              () => TSwipeCard(
                                image: controller
                                    .allUsers[index].profilePictures[controller.currentPhotoIndex.value],
                                currentPhoto: controller.currentPhotoIndex.value,
                                numberPhotos: numberOfPhoto,
                                heightWidthHomeDetail: true,
                                borderRadiusImage: false,
                                shadowImage: false,
                                onLeftTap: () => controller.previousPhoto(numberOfPhoto),
                                onRightTap: () => controller.nextPhoto(numberOfPhoto),
                              ),
                            ),

                            // Dot Image Navigation
                            Obx(
                              () => TImageNavigationDots(
                                currentPhoto: controller.currentPhotoIndex.value,
                                numberPhotos: numberOfPhoto,
                              ),
                            ),

                            // Arrow Down
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16, bottom: 10),
                                child: Material(
                                  color: TColors.primary,
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(100),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/icons/home/arrow_down.png',
                                          scale: 20,
                                          color: Colors.white,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Detail Information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(TSizes.defaultSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Name
                                  Text(name, style: Theme.of(context).textTheme.headlineMedium),
                                  const SizedBox(width: TSizes.sm),

                                  // Age
                                  Text(
                                    age,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 25),
                                  )
                                ],
                              ),
                              const SizedBox(height: TSizes.xs),

                              // Location
                              Row(
                                children: [
                                  // Icon
                                  const Icon(Iconsax.location, size: TSizes.iconXs),
                                  const SizedBox(width: TSizes.sm),

                                  // Location
                                  Text('Da Nang', style: Theme.of(context).textTheme.labelLarge)
                                ],
                              ),
                              const SizedBox(height: TSizes.sm),
                              const Divider(),
                              const SizedBox(height: TSizes.sm),

                              // Looking
                              Row(
                                children: [
                                  // Icon
                                  Icon(Iconsax.search_favorite,
                                      size: TSizes.iconMd - 5,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6)),
                                  const SizedBox(width: TSizes.sm),

                                  // Location
                                  Text('Looking',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: dark ? TColors.white : Colors.black.withOpacity(0.6))),
                                ],
                              ),
                              const SizedBox(height: TSizes.md),

                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: Text('💘 Lover', style: Theme.of(context).textTheme.headlineSmall),
                              ),

                              const SizedBox(height: TSizes.sm),
                              const Divider(),
                              const SizedBox(height: TSizes.sm),

                              // Hobbies
                              Row(
                                children: [
                                  // Icon
                                  Icon(Iconsax.like,
                                      size: TSizes.iconMd - 5,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6)),
                                  const SizedBox(width: TSizes.sm),

                                  // Title
                                  Text('Hobby',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: dark ? TColors.white : Colors.black.withOpacity(0.6))),
                                ],
                              ),
                              const SizedBox(height: TSizes.md),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: dark ? Colors.black.withOpacity(0.4) : TColors.grey,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                child: Text('Take care of yourself',
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Action Button
            Positioned(
              bottom: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nope Action Button
                  TActionButton(
                    assetPath: 'assets/icons/home/clear.png',
                    color: Colors.red,
                    size: 60,
                    onTap: () {
                      // _matchEngine.currentItem!.nope();
                    },
                    hasBorder: false,
                    hasElevation: true,
                    hasBorderRadius: true,
                    coloTransparent: false,
                  ),
                  const SizedBox(width: 20),

                  // Star Action Button
                  TActionButton(
                    assetPath: 'assets/icons/home/star.png',
                    color: Colors.blueAccent,
                    size: 50,
                    onTap: () {
                      // _matchEngine.currentItem!.superLike();
                    },
                    hasBorder: false,
                    hasElevation: true,
                    hasBorderRadius: true,
                    coloTransparent: false,
                  ),
                  const SizedBox(width: 20),

                  // Heart Action Button
                  TActionButton(
                    assetPath: 'assets/icons/home/heart.png',
                    color: Colors.green,
                    size: 60,
                    onTap: () {
                      // _matchEngine.currentItem!.like();
                    },
                    hasBorder: false,
                    hasElevation: true,
                    hasBorderRadius: true,
                    coloTransparent: false,
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
