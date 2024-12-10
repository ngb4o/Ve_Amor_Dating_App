import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/bottom_button/bottom_button.dart';
import '../../../../../common/widgets/question_section/filter_chip.dart';
import '../../../../../utils/constants/sizes.dart';

class ProfileBottomSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final bool isMultiSelect;
  final dynamic selectedValue;
  final Function(String) onOptionSelected;
  final VoidCallback onSave;

  const ProfileBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.isMultiSelect,
    required this.selectedValue,
    required this.onOptionSelected,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.md),
          topRight: Radius.circular(TSizes.md),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header bar indicator
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: TSizes.md),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(TSizes.xs),
              ),
            ),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options
            Obx(() => Wrap(
                  spacing: TSizes.xs,
                  runSpacing: TSizes.xs,
                  children: options.map((option) {
                    bool isSelected = isMultiSelect
                        ? (selectedValue as RxList).contains(option)
                        : selectedValue.value == option;

                    return TFilterChip(
                      label: option,
                      selected: isSelected,
                      onSelected: (_) => onOptionSelected(option),
                    );
                  }).toList(),
                )),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Done button
            TBottomButton(
              onPressed: onSave,
              textButton: 'Done',
            ),
            const SizedBox(height: TSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
