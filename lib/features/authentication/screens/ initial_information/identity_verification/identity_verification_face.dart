part of '../initial_information_imports.dart';

class InitialIdentityVerificationFace extends StatelessWidget {
  const InitialIdentityVerificationFace({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InitialInformationController.instance;
    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.titleIdentityVerificationFace,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.subTitleIdentityVerificationFace,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Camera Button
              GestureDetector(
                onTap: () async {
                  final imagePath = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomCameraScreen(),
                    ),
                  );

                  if (imagePath != null) {
                    await controller.saveFaceImage(imagePath);
                  }
                },
                child: Container(
                  width: THelperFunctions.screenWidth(),
                  height: 120,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(TImages.camera),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: TSizes.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TTexts.captureFrom,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: TColors.white),
                        ),
                        Text(
                          TTexts.camera,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: TColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
