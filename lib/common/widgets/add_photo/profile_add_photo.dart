part of '../../../features/main/screens/profile/widgets/widget_imports.dart';

class TProfileAddPhoto extends StatelessWidget {
  const TProfileAddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.clear, size: 30, color: TColors.primary)),
      ),
      body: SizedBox(
        width: THelperFunctions.screenWidth(),
        height: THelperFunctions.screenHeight(),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(TTexts.createNew, style: Theme.of(context).textTheme.headlineMedium),
              Text(TTexts.selectImage, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: TSizes.spaceBtwSections),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Camera
                    Container(
                      width: THelperFunctions.screenWidth(),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(TImages.picture),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: TSizes.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              TTexts.upload,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.white),
                            ),
                            Text(
                              TTexts.photo,
                              style:
                                  Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Picture
                    Container(
                      width: THelperFunctions.screenWidth(),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(TImages.camera),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: TSizes.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              TTexts.captureFrom,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.white),
                            ),
                            Text(
                              TTexts.camera,
                              style:
                                  Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
