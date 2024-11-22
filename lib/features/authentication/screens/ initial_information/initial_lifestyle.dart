part of 'initial_information_imports.dart';

class InitialLifestylePage extends StatelessWidget {
  const InitialLifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.sm),

            // SubTitle
            Text(TTexts.subTitleLifestyle, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: TSizes.sm),
            const Divider(),

          const QuestionSection(
            question: 'What is your zodiac sign?',
            options: [
              'Aries (Mar 21 - Apr 19)',
              'Taurus (Apr 20 - May 20)',
              'Gemini (May 21 - Jun 20)',
              'Cancer (Jun 21 - Jul 22)',
              'Leo (Jul 23 - Aug 22)',
              'Virgo (Aug 23 - Sep 22)',
              'Libra (Sep 23 - Oct 22)',
              'Scorpio (Oct 23 - Nov 21)',
              'Sagittarius (Nov 22 - Dec 21)',
              'Capricorn (Dec 22 - Jan 19)',
              'Aquarius (Jan 20 - Feb 18)',
              'Pisces (Feb 19 - Mar 20)',
            ],
          ),

            const Divider(),

            const QuestionSection(
              question: 'Do you exercise?',
              options: [
                'Daily',
                'Frequently',
                'Occasionally',
                'Don’t exercise',
              ],
            ),
            const Divider(),

            const QuestionSection(
              question: 'Do you have pets?',
              options: [
                'Dog',
                'Cat',
                'Fish',
                'Rabbit',
                'Hamster',
                'Turtle',
                'No pets',
                'Allergic to animals',
                'All kinds of pets',
                'Others',
              ],
            ),

            const SizedBox(height: 24),

            // Button Next
            TBottomButton(
              onPressed: () {

              },
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
