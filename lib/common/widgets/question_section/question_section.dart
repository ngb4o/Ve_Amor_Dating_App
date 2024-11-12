import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class QuestionSection extends StatelessWidget {
  final String question;
  final List<String> options;

  const QuestionSection({
    super.key,
    required this.question,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              return ChoiceChip(
                label: Text(option),
                selected: false,
                onSelected: (selected) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                labelStyle: const TextStyle(fontSize: 11),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}