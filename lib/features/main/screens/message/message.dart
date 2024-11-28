part of 'message_imports.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = HomeController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.allUsers.isEmpty) {
                        return const TMessageEmpty(small: true);  // If no users
                      } else {
                        return SizedBox(
                          height: 160,
                          child: Row(
                            children: [
                              const NewMatchLikesCard(),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.allUsers.length,
                                  itemBuilder: (context, index) {
                                    final user = controller.allUsers[index];
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
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.allUsers.isEmpty) {
                        return const TMessageEmpty();  // If no users
                      } else {
                        return Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.allUsers.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final user = controller.allUsers[index];
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
                                    message: 'Hello',  // Placeholder message
                                  ),
                                );
                              },
                            ),

                            // Chatbot button
                            GestureDetector(
                              onTap: () => Get.to(() => ChatBotScreen()),
                              child: TMessageCard(
                                imagePath: TImages.lightAppLogo,
                                name: 'AI Chatbot',
                                message: 'Ask me anything!',
                                isNetworkImage: false,
                              ),
                            ),

                            // Fixed message card
                            const TMessageCard(
                              imagePath: TImages.lightAppLogo,
                              name: 'Team VeAmor',
                              message: 'Upgrade now to start matching',
                              isVerify: true,
                              isNetworkImage: false,
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
        onPressed: () => Get.to(() => ChatBotScreen()), // Navigate to ChatBotScreen
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
