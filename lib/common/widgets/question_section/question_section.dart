import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';

import '../../../features/authentication/controller/initial_information/initial_information_controller.dart';
import '../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/helper_functions.dart';

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
    final dark = THelperFunctions.isDarkMode(context);

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
                  label: Text(option, style: TextStyle(color: dark ? TColors.white : Colors.black)),
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
