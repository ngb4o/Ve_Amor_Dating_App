part of 'initial_information_imports.dart';

class InitialFindingRelationshipPage extends StatelessWidget {
  const InitialFindingRelationshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = InitialInformationController.instance;
    // List of options
    final options = [
      {'icon': Icons.favorite, 'text': 'Lover'},
      {'icon': Icons.favorite_border, 'text': 'A long-term dating partner'},
      {'icon': Icons.emoji_events, 'text': 'Anything that might happen'},
      {'icon': Icons.celebration, 'text': 'A casual relationship'},
      {'icon': Icons.people, 'text': 'New friends'},
      {'icon': Icons.question_mark, 'text': 'I’m not sure yet'},
    ];

    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                TTexts.titleRelationship,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Subtitle
              Text(
                TTexts.subTitleRelationship,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Options grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return Obx(() {
                    // Check if the option is selected
                    final isSelected =
                        controller.selectedFindingRelationship.value == option['text'];
                    return GestureDetector(
                      onTap: () {
                        // Update selection when tapped
                        controller.updateFindingRelationship(option['text'].toString());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? TColors.primary.withOpacity(0.1)
                              : dark
                                  ? TColors.dark
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: isSelected ? TColors.primary : Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              option['icon'] as IconData,
                              color: TColors.primary,
                              size: 35,
                            ),
                            const SizedBox(height: TSizes.sm),
                            Text(
                              option['text'] as String,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: isSelected
                                        ? TColors.primary
                                        : dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Next Button
              TBottomButton(
                onPressed: () {
                  controller.saveFindingRelationship();
                },
                textButton: 'Next',
              )
            ],
          ),
        ),
      ),
    );
  }
}
