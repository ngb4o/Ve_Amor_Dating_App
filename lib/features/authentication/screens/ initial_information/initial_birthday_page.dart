part of 'initial_information_imports.dart';

class InitialBirthdayPage extends StatelessWidget {
  const InitialBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = InitialInformationController.instance;

    // Create a TextEditingController
    final dateOfBirthController = TextEditingController();

    // Format the input as the user types
    dateOfBirthController.addListener(() {
      String text = dateOfBirthController.text;
      // Remove all non-digit characters
      text = text.replaceAll(RegExp(r'\D'), '');

      // Format the text
      String formattedText = '';
      if (text.length >= 2) {
        formattedText += text.substring(0, 2); // Day
        formattedText += '/'; // Add slash after day
        if (text.length > 2) {
          formattedText += text.substring(2, 4); // Month
          formattedText += '/'; // Add slash after month
          if (text.length > 4) {
            formattedText += text.substring(4); // Year
          }
        }
      } else {
        formattedText = text; // If less than 2 digits, just show the input
      }

      // Update the controller's text
      dateOfBirthController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );

      // Update the controller's dateOfBirth value
      controller.dateOfBirth.text = formattedText; // Update the controller's dateOfBirth
    });

    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.titleBirthday,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // TextField
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.cake),
                hintText: 'D D / M M / Y Y Y Y',
                hintStyle: TextStyle(
                  color: dark ? TColors.grey.withOpacity(0.5) : TColors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Sub Title
            Text(TTexts.subTitleBirthday, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),

            // Button Next
            TBottomButton(
              onPressed: () => controller.saveBirthday(),
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}