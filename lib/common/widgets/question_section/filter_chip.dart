import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TFilterChip extends StatelessWidget {
  const TFilterChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
  });

  final String label;
  final bool selected;
  final Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color:
              selected ? TColors.white : (dark ? TColors.white : TColors.black),
        ),
      ),
      backgroundColor: dark ? Colors.black : Colors.white,
      selectedColor: TColors.primary,
      selected: selected,
      checkmarkColor: TColors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.sm, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onSelected: onSelected,
    );
  }
}
