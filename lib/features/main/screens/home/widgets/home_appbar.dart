import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ve_amor_app/common/widgets/appbar/appbar.dart';
import 'package:ve_amor_app/common/widgets/appbar/notification_menu_icon.dart';
import 'package:ve_amor_app/features/main/screens/home/widgets/widget_imports.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/image_strings.dart';
import 'package:ve_amor_app/utils/constants/text_strings.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar(
      {super.key,
      this.iconSecurityActionAppbar = false,
      this.showActionButtonAppbar = true,
      this.centerAppbar = false,
      this.showBackArrow = false,
      this.centerTitle = false,
      this.showIconFilter = false});

  final bool iconSecurityActionAppbar;
  final bool showActionButtonAppbar;
  final bool centerAppbar;
  final bool showBackArrow;
  final bool centerTitle;
  final bool showIconFilter;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TAppbar(
      showBackArrow: showBackArrow,
      title: Row(
        mainAxisAlignment: centerAppbar ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Image.asset(width: 60, height: 75, TImages.veAmorLogo),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.homeAppbarTitle,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.primary),
              ),
              Text(
                TTexts.appName,
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.primary),
              ),
            ],
          ),
        ],
      ),
      actions: showActionButtonAppbar
          ? [
              TActionAppbarIcon(
                icon: iconSecurityActionAppbar ? Icons.security : Iconsax.notification5,
                iconColor: dark ? TColors.grey : TColors.black.withOpacity(0.7),
                onPressed: () {},
              ),
              if (showIconFilter)
                TActionAppbarIcon(
                  icon: Iconsax.filter5,
                  iconColor: dark ? TColors.grey : TColors.black.withOpacity(0.7),
                  onPressed: () => Get.to(() => const HomeFilterScreen()),
                ),
            ]
          : [],
    );
  }
}
