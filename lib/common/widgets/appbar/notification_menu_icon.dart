import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class TNotifiCounterIcon extends StatelessWidget {
  const TNotifiCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Iconsax.notification5,
        size: 26,
        color: iconColor,
      ),
    );
  }
}
