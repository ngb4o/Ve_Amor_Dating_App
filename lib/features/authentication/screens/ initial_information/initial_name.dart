part of 'initial_information_imports.dart';

class InitialNamePage extends StatelessWidget {
  const InitialNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InitialInformationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppbar(showBackArrow: false),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.initialName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // TextField

            TextField(
              controller: controller.userName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.user),
                hintText: 'Enter name',
                hintStyle:
                    TextStyle(color: dark ? TColors.grey.withOpacity(0.5) : TColors.black.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Sub Title
            Text(TTexts.subInitialName1, style: Theme.of(context).textTheme.bodySmall),
            Text(
              TTexts.subInitialName2,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),

            // Button Next
            TBottomButton(
              onPressed: () => controller.saveName(),
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
