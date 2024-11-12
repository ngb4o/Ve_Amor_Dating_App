part of 'initial_information_imports.dart';

class InitialGenderPage extends StatefulWidget {
  const InitialGenderPage({super.key});

  @override
  State<InitialGenderPage> createState() => _InitialGenderPageState();
}

class _InitialGenderPageState extends State<InitialGenderPage> {
  // Gender options
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  selectedGender = TTexts.women;
                });
              },
              child: optionContainer(context, TTexts.women, selectedGender == TTexts.women),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 2
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = TTexts.men;
                });
              },
              child: optionContainer(context, TTexts.men, selectedGender == TTexts.men),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Options 3
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = TTexts.other;
                });
              },
              child: optionContainer(context, TTexts.other, selectedGender == TTexts.other),
            ),

            const Spacer(),

            // Button Next
            TBottomButton(
              onPressed: () => Get.to(() => const InitialInterestedPage()),
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }

  Container optionContainer(BuildContext context, String gender, bool isSelected) {
    return Container(
      width: THelperFunctions.screenWidth(),
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isSelected ? TColors.primary : TColors.grey, width: 2),
      ),
      child: Center(child: Text(gender, style: Theme.of(context).textTheme.headlineSmall)),
    );
  }
}
