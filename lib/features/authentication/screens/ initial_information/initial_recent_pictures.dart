part of 'initial_information_imports.dart';

class InitialRecentPicturePage extends StatelessWidget {
  const InitialRecentPicturePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              TTexts.titleRecentPicture,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // SubTitle
            Text(TTexts.subTitleRecentPicture, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: TSizes.spaceBtwSections),

            const TProFilePhoto(),

            const Spacer(),

            // Button Next
            TBottomButton(
              onPressed: () async {
                await controller.saveImages();
                controller.updateInitialInformation();
              },
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
