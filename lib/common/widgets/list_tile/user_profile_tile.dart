
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      // Image
      leading: const TCircularImage(
          image: TImages.user, width: 50, height: 50, padding: 0),

      // Name
      title: Text(
        'Nguyễn Gia Bảo',
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
      ),

      // Email
      subtitle: Text(
        'ngbao08052003@gmail.com',
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
  }
}
