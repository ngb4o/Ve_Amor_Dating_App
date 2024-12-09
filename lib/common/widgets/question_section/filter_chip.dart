import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TFilterChip extends StatelessWidget {
  const TFilterChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 13),
      ),
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.pink[50],
      checkmarkColor: Colors.pink,
      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onSelected: (bool value) {},
    );
  }
}
