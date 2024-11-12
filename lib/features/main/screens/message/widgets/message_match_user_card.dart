import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/constants/image_strings.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';

class TNewMatchUserCard extends StatelessWidget {
  const TNewMatchUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: TSizes.iconXs),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
            child: Image.asset(
              TImages.girl,
              width: 110,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: TSizes.xs),
          Text(
            'Yogurt',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}