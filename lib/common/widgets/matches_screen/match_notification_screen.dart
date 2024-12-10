import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ve_amor_app/common/widgets/loaders/shimmer.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';

class MatchNotificationScreen extends StatelessWidget {
  final String currentUserImage;
  final String matchedUserImage;
  final String matchedUserName;

  const MatchNotificationScreen({
    super.key,
    required this.currentUserImage,
    required this.matchedUserImage,
    required this.matchedUserName,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie Animation
            Lottie.asset(
              Assets.animations120978PaymentSuccessful,
              height: 110,
              repeat: true,
            ),

            // Profile Images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Current User Image
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: currentUserImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const TShimmerEffect(
                      width: 120,
                      height: 120,
                      radius: 60,
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/content/user.png'),
                    ),
                  ),
                ),

                const SizedBox(width: TSizes.spaceBtwItems),

                // Matched User Image
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: matchedUserImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const TShimmerEffect(
                      width: 120,
                      height: 120,
                      radius: 60,
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/content/user.png'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Match Text
            Text(
              "It's a Match!",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: TSizes.sm),
            Text(
              'You and $matchedUserName have liked each other',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: TSizes.md),
                      ),
                      child: const Text('Keep Swiping'),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to chat with matched user
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: TColors.primary,
                        padding:
                            const EdgeInsets.symmetric(vertical: TSizes.md),
                      ),
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
