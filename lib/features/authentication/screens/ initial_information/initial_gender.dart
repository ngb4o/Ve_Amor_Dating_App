part of 'initial_information_imports.dart';

class InitialGenderPage extends StatefulWidget {
  const InitialGenderPage({super.key});

  @override
  State<InitialGenderPage> createState() => _InitialGenderPageState();
}

class _InitialGenderPageState extends State<InitialGenderPage> {
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
              TTexts.titleGender,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Options 1
            GestureDetector(
              onTap: () {
                controller.updateGender(TTexts.women);
              },
              child: Obx(() => optionContainer(
                    context,
                    TTexts.women,
                    controller.selectedGender.value == TTexts.women,
                  )),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 2
            GestureDetector(
              onTap: () {
                controller.updateGender(TTexts.men);
              },
              child: Obx(() => optionContainer(
                    context,
                    TTexts.men,
                    controller.selectedGender.value == TTexts.men,
                  )),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 3
            GestureDetector(
              onTap: () {
                controller.updateGender(TTexts.other);
              },
              child: Obx(() => optionContainer(
                    context,
                    TTexts.other,
                    controller.selectedGender.value == TTexts.other,
                  )),
            ),

            const Spacer(),

            // Button Next
            Obx(() {
              final isEnabled = controller.selectedGender.value.isNotEmpty;
              return TBottomButton(
                onPressed: isEnabled ? () => controller.saveGender() : null,
                textButton: 'Next',
              );
            }),
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
        border: Border.all(color: isSelected ? TColors.primary : TColors.grey, width: 2)
      ),
      child: Center(child: Text(gender, style: Theme.of(context).textTheme.headlineSmall)),
    );
  }
}
