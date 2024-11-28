import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/common/widgets/appbar/appbar.dart';
import 'package:ve_amor_app/features/main/controller/home/home_controller.dart';
import 'package:ve_amor_app/features/main/screens/message/chat/widgets/widget_imports.dart';
import 'package:ve_amor_app/utils/constants/image_strings.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/loaders/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/message/message_controller.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
    this.isNetworkImage = true,
    required this.imagePath,
    required this.name,
    required this.receiverID,
  });

  final bool isNetworkImage;
  final String imagePath;
  final String name;
  final String receiverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final homeController = HomeController.instance;
  final _messageController = Get.put(MessageController());
  final ScrollController _scrollController = ScrollController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // Delay the scroll to the bottom until the keyboard is visible
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );

// Load messages on page init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messageController.loadMessages(FirebaseAuth.instance.currentUser!.uid, widget.receiverID);
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  // Scroll to the bottom
  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Column(
          children: [
            ClipOval(
              child: widget.isNetworkImage
                  ? CachedNetworkImage(
                      imageUrl: widget.imagePath,
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const TShimmerEffect(
                        width: 35,
                        height: 35,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                    )
                  : Image.asset(
                      dark ? TImages.darkAppLogo : TImages.lightAppLogo, // For local assets
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        isCenterTitle: true,
        actions: const [
          Icon(Iconsax.more),
        ],
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: Obx(() {
              final messages = _messageController.messages;
              final isLoading = _messageController.isLoading.value;

              // Loading
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Empty
              if (messages.isEmpty) {
                return TChatEmpty(
                  name: widget.name,
                  imagePath: widget.imagePath,
                );
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment:
                        message.senderID == currentUserID ? Alignment.centerRight : Alignment.centerLeft,
                    child: GestureDetector(
                      onLongPress: () {
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
                        decoration: BoxDecoration(
                          color: message.senderID == currentUserID ? TColors.primary : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: myFocusNode,
                    controller: _messageController.messageTextController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.md),
                Container(
                  decoration: const BoxDecoration(color: TColors.primary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(
                      Iconsax.arrow_up,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await _messageController.sendMessage(widget.receiverID);
                      scrollDown();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
