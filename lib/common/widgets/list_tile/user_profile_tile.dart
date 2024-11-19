import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/common/widgets/loaders/shimmer.dart';

import '../../../features/personalization/controller/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Obx(() {
      if (controller.profileLoading.value) {
        // Display A Shimmer Loader While User Profile being loader
        return const TShimmerEffect(width: 80, height: 20);
      }
      return ListTile(
        // Image
        leading: TCircularImage(
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: true,
          image: controller.user.value.profilePictures[0],
        ),

        // Name
        title: Text(
          controller.user.value.username,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
        ),

        // Email
        subtitle: Text(
          controller.user.value.email,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
        ),

        // Edit
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          ),
        ),
      );
    });
  }
}
