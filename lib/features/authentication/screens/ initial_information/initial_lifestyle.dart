part of 'initial_information_imports.dart';

class InitialLifestylePage extends StatelessWidget {
  const InitialLifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InitialInformationController.instance;
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        // actions: [
        //   // Skip button
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       'Skip',
        //       style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.primary),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.titleLifestyle,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.sm),

            // SubTitle
            Text(TTexts.subTitleLifestyle,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: TSizes.sm),
            const Divider(),

            const QuestionSection(
              questionKey: LifestyleOptions.zodiacField,
              question: 'What is your zodiac sign?',
              options: LifestyleOptions.zodiacOptions,
              isSelectedOnly: true,
            ),

            const Divider(),

            const QuestionSection(
              questionKey: LifestyleOptions.sportsField,
              question: 'What sport do you like?',
              options: LifestyleOptions.sportsOptions,
              isSelectedOnly: false,
            ),

            const Divider(),

            const QuestionSection(
              questionKey: LifestyleOptions.petsField,
              question: 'Do you have pets?',
              options: LifestyleOptions.petsOptions,
              isSelectedOnly: false,
            ),

            const SizedBox(height: 24),

            // Button Next
            TBottomButton(
              onPressed: () => controller.saveLifestyle(),
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
