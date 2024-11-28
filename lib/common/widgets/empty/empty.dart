import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TEmpty extends StatelessWidget {
  const TEmpty({
    super.key,
    this.small = false,
    required this.titleText,
    required this.subTitleText,
  });

  final bool small;
  final String titleText;
  final String subTitleText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: small ? null : MediaQuery.of(context).size.height - 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.layer5, size: small ? 50 : 100, color: TColors.primary),
            if (!small) ...[
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                titleText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                subTitleText,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
