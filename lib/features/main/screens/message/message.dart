part of 'message_imports.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchAllUsersMatches();
        },
        color: TColors.white,
        backgroundColor: TColors.primary,
        child: ListView(
          children: [
            // Appbar
            const THomeAppBar(iconSecurityActionAppbar: true),

            // New Matches Section
            Padding(
              padding: const EdgeInsets.only(
                top: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                right: TSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const TSectionHeading(title: TTexts.newMatches),
                  const SizedBox(height: TSizes.spaceBtwItems - 5),

                  // Card for displaying new matches
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return TShimmerEffect(
                          width: THelperFunctions.screenWidth(),
                          height: THelperFunctions.screenHeight(),
                        );
                      } else if (controller.allUsersMatches.isEmpty) {
                        return const TEmpty(
                          small: true,
                          titleText: '',
                          subTitleText: '',
                        );
                      } else {
                        return SizedBox(
                          height: 160,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => const UpgradeCardDetailScreen(
                                    subscriptionType: "Plus",
                                    index: 0,
                                    onlyOne: true,
                                  ),
                                ),
                                child: const NewMatchLikesCard(),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.allUsersMatches.length,
                                  itemBuilder: (context, index) {
                                    final user = controller.allUsersMatches[index];
                                    return GestureDetector(
                                      onTap: () => Get.to(
                                        () => ChatPage(
                                          imagePath: user.profilePictures[0],
                                          name: user.username,
                                          receiverID: user.id,
                                        ),
                                      ),
                                      child: TNewMatchUserCard(
                                        name: user.username,
                                        image: user.profilePictures[0],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),

            // Message Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                children: [
                  // Title for Message section
                  const TSectionHeading(title: TTexts.message),
                  const SizedBox(height: TSizes.spaceBtwItems - 5),

                  // List of Messages
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return TShimmerEffect(
                          width: THelperFunctions.screenWidth(),
                          height: THelperFunctions.screenHeight(),
                        );
                      } else if (controller.allUsersMatches.isEmpty) {
                        return const TEmpty(
                          titleText: TTexts.titleChatEmpty,
                          subTitleText: TTexts.subTitleChatEmpty,
                        );
                      } else {
                        return Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.allUsersMatches.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final user = controller.allUsersMatches[index];
                                return GestureDetector(
                                  onTap: () => Get.to(
                                    () => ChatPage(
                                      imagePath: user.profilePictures[0],
                                      name: user.username,
                                      receiverID: user.id,
                                    ),
                                  ),
                                  child: TMessageCard(
                                    imagePath: user.profilePictures[0],
                                    name: user.username,
                                    message: 'Tap to start message', // Placeholder message
                                  ),
                                );
                              },
                            ),

                            // Fixed message card
                            GestureDetector(
                              onTap: () => Get.to(
                                () => const UpgradeCardDetailScreen(
                                  subscriptionType: "Platinum",
                                  index: 2,
                                  onlyOne: true,
                                ),
                              ),
                              child: const TMessageCard(
                                imagePath: TImages.lightAppLogo,
                                name: 'Team VeAmor',
                                message: 'Upgrade now to start matching',
                                isVerify: true,
                                isNetworkImage: false,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // Floating chat icon button at the bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const ChatBotScreen()), // Navigate to ChatBotScreen
        backgroundColor: TColors.primary,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
