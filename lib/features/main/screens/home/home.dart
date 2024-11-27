part of 'home_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.showBackArrow = false,
    this.centerTitle = false,
  });

  final bool showBackArrow;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    late MatchEngine matchEngine;

    return Scaffold(
      body: Column(
        children: [
          // Appbar
          THomeAppBar(showBackArrow: showBackArrow, centerTitle: centerTitle),

          // Swipe Card
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.allUsers.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TEmpty(titleText: '', subTitleText: ''),
              );
            } else {
              final items = controller.allUsers.map((user) {
                return SwipeItem(
                  content: user.username,
                  likeAction: () async {
                    await controller.likeUser(user.id);
                    controller.resetPhotoIndex();
                  },
                  nopeAction: () async {
                    await controller.nopeUser(user.id);
                    controller.resetPhotoIndex();
                  },
                  superlikeAction: () {
                    controller.resetPhotoIndex();
                  },
                  onSlideUpdate: (SlideRegion? region) async {},
                );
              }).toList();

              matchEngine = MatchEngine(swipeItems: items);

              return Expanded(
                child: SwipeCards(
                  matchEngine: matchEngine,
                  upSwipeAllowed: true,
                  onStackFinished: () {
                    controller.resetPhotoIndex();
                  },
                  itemBuilder: (context, index) {
                    final user = controller.allUsers[index];
                    final numberPhotos = user.profilePictures.length;

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                      child: SizedBox(
                        width: THelperFunctions.screenWidth(),
                        height: THelperFunctions.screenHeight(),
                        child: Hero(
                          tag: 'imageTage$index',
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Card
                              Obx(() => TSwipeCard(
                                    currentPhoto: controller.currentPhotoIndex.value,
                                    numberPhotos: numberPhotos,
                                    image: user.profilePictures[controller.currentPhotoIndex.value],
                                    onLeftTap: () => controller.previousPhoto(numberPhotos),
                                    onRightTap: () => controller.nextPhoto(numberPhotos),
                                  )),

                              // Dot Image Navigation
                              Obx(() => TImageNavigationDots(
                                    currentPhoto: controller.currentPhotoIndex.value,
                                    numberPhotos: numberPhotos,
                                  )),

                              // Information
                              Obx(
                                () => Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: TInfoSection(
                                          index: index,
                                          image: user
                                              .profilePictures[controller.currentPhotoIndex.value],
                                        ),
                                      ),
                                      const SizedBox(height: TSizes.md),

                                      // Action Button
                                      TActionButtonRow(matchEngine: matchEngine),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
