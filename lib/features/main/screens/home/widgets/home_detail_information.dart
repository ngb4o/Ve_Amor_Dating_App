part of 'widget_imports.dart';

class THomeDetailInformation extends StatelessWidget {
  const THomeDetailInformation(
    this.index, {
    super.key,
  });

  final int index;

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
                                numberPhotos: controller.allUsers[index].profilePictures.length,
                                heightWidthHomeDetail: true,
                                borderRadiusImage: false,
                                shadowImage: false,
                                onLeftTap: () => controller
                                    .previousPhoto(controller.allUsers[index].profilePictures.length),
                                onRightTap: () =>
                                    controller.nextPhoto(controller.allUsers[index].profilePictures.length),
                              ),
                            ),

                            // Dot Image Navigation
                            Obx(
                              () => TImageNavigationDots(
                                currentPhoto: controller.currentPhotoIndex.value,
                                numberPhotos: controller.allUsers[index].profilePictures.length,
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
                                      height: 50,
                                      width: 50,
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
                                        ),
                                      ),
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
                                  Text(controller.allUsers[index].username,
                                      style: Theme.of(context).textTheme.headlineMedium),
                                  const SizedBox(width: TSizes.sm),

                                  // Age
                                  Text(
                                    controller.allUsers[index].age.toString(),
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
                                  Text(controller.allUsers[index].location?['address'],
                                      style: Theme.of(context).textTheme.labelLarge)
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
                                child: Text('💘 ${controller.allUsers[index].findingRelationship}',
                                    style: Theme.of(context).textTheme.bodyLarge),
                              ),

                              const SizedBox(height: TSizes.sm),
                              const Divider(),
                              const SizedBox(height: TSizes.sm),

                              // Zodiac
                              Row(
                                children: [
                                  // Icon
                                  Icon(Icons.ac_unit,
                                      size: TSizes.iconMd - 5,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6)),
                                  const SizedBox(width: TSizes.sm),

                                  // Title
                                  Text(
                                    'Zodiac',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.md),

                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: Text('✨ ${controller.allUsers[index].zodiac}',
                                    style: Theme.of(context).textTheme.bodyLarge),
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
                                  Text(
                                    'Lifestyle habits and personalities',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.md),

                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: controller.allUsers[index].sports.map((lifestyle) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: TColors.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    child: Text(
                                      lifestyle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: TColors.white),
                                    ),
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: TSizes.sm),
                              const Divider(),
                              const SizedBox(height: TSizes.sm),

                              // Pets
                              Row(
                                children: [
                                  // Icon
                                  Icon(Iconsax.pet,
                                      size: TSizes.iconMd - 5,
                                      color: dark ? TColors.white : Colors.black.withOpacity(0.6)),
                                  const SizedBox(width: TSizes.sm),

                                  // Title
                                  Text(
                                    'Pets',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: dark ? TColors.white : Colors.black.withOpacity(0.6),
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.md),

                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: controller.allUsers[index].pets.map((pet) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: TColors.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    child: Text(
                                      pet,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: TColors.white),
                                    ),
                                  );
                                }).toList(),
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
                    onTap: () async {
                      await controller.nopeUser(controller.allUsers[index].id);
                      controller.resetPhotoIndex();
                      Navigator.pop(context);
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
                    onTap: () async {
                      await controller.likeUser(
                          controller.allUsers[index].id, controller.allUsers[index].username);
                      controller.resetPhotoIndex();
                      Navigator.pop(context);
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
