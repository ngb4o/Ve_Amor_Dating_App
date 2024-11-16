part of 'initial_information_imports.dart';

class InitialBirthdayPage extends StatelessWidget {
  const InitialBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = InitialInformationController.instance;
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
                controller: controller.dateOfBirth,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.cake),
                  hintText: 'D D / M M / Y Y Y Y',
                  hintStyle: TextStyle(
                      color: dark ? TColors.grey.withOpacity(0.5) : TColors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
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
