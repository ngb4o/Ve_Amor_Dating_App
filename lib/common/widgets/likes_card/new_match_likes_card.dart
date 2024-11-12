import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/image_strings.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

class NewMatchLikesCard extends StatelessWidget {

  const NewMatchLikesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: TSizes.iconXs),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset(
                    dark ? TImages.lightAppLogo : TImages.darkAppLogo,
                    width: 110,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                  border: Border.all(color: TColors.primary, width: 2),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: TColors.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '3',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.xs),
          Text(
            'Likes',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
