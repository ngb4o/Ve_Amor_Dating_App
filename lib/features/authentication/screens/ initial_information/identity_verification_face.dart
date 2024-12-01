part of 'initial_information_imports.dart';


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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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

                    // Preview Image or Camera Button
                    Obx(
                          () => GestureDetector(
                        onTap: () async {
                          final imagePath = await Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomCameraScreen(),
                            ),
                          );

                          if (imagePath != null) {
                            controller.faceImage.value = imagePath;
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: THelperFunctions.screenWidth(),
                              height: controller.faceImage.value != null
                                  ? THelperFunctions.screenWidth() * 4 / 3 // Chiều cao cho ảnh đã chụp
                                  : 120, // Chiều cao ban đầu cho camera button
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: controller.faceImage.value != null ? Colors.black : null,
                              ),
                              child: controller.faceImage.value != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(controller.faceImage.value!),
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Container(
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
                            const SizedBox(height: TSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    ),

                    const Expanded(child: SizedBox()),
                    // Button Next
                    TBottomButton(
                      onPressed: () async {
                        await controller.saveFaceImage(controller.faceImage.value!);

                        // Sau khi lưu ảnh thành công thì chuyển trang
                        Get.to(() => const InitialRecentPicturePage());
                      },
                      textButton: 'Next',
                    ),
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
