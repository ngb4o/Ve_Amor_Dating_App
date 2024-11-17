part of 'initial_information_imports.dart';

class InitialInterestedPage extends StatelessWidget {
  const InitialInterestedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InitialInformationController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.titleInterested,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Options 1
            GestureDetector(
              onTap: () => controller.updateWantSeeing(TTexts.women),
              child: Obx(() =>
                  optionContainer(context, TTexts.women, controller.selectedWantSeeing.value == TTexts.women)),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 2
            GestureDetector(
              onTap: () => controller.updateWantSeeing(TTexts.men),
              child: Obx(() =>
                  optionContainer(context, TTexts.men, controller.selectedWantSeeing.value == TTexts.men)),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 3
            GestureDetector(
              onTap: () => controller.updateWantSeeing(TTexts.everyone),
              child: Obx(() => optionContainer(
                  context, TTexts.everyone, controller.selectedWantSeeing.value == TTexts.everyone)),
            ),

            const Spacer(),

            // Button Next
            Obx(() {
              final isEnabled = controller.selectedWantSeeing.value.isNotEmpty;
              return TBottomButton(
                onPressed: isEnabled ? () {
                  controller.saveWantSeeing();
                } : null,
                textButton: 'Next',
              );
            })
          ],
        ),
      ),
    );
  }

  Container optionContainer(BuildContext context, String gender, bool isSelected) {
    return Container(
      width: THelperFunctions.screenWidth(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isSelected ? TColors.primary : TColors.grey, width: 2),
      ),
      child: Center(child: Text(gender, style: Theme.of(context).textTheme.headlineSmall)),
    );
  }
}
