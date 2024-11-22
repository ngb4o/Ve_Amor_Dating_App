import 'package:flutter/material.dart';

import '../../../features/authentication/controller/initial_information/initial_information_controller.dart';
import '../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class QuestionSection extends StatelessWidget {
  final String questionKey;
  final String question;
  final List<String> options;
  final bool isSelectedOnly;

  const QuestionSection({
    super.key,
    required this.questionKey,
    required this.question,
    required this.options,
    this.isSelectedOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = InitialInformationController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final selectedOptions = controller.questionAnswers[questionKey] ?? [];
            return Wrap(
              spacing: 8,
              runSpacing: 5,
              children: options.map((option) {
                final isSelected = selectedOptions.contains(option);
                return ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (_) {
                    if (isSelectedOnly) {
                      controller.clearAndAddSingleOption(questionKey, option);
                    } else {
                      controller.toggleLifestyleOption(questionKey, option);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}

