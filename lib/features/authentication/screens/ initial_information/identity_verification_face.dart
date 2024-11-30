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

                    // Camera Button
                    GestureDetector(
                      onTap: () async {
                        try {
                          final ImagePicker picker = ImagePicker();
                          // Bắt buộc sử dụng camera trước
                          final XFile? photo = await picker.pickImage(
                            source: ImageSource.camera,
                            preferredCameraDevice: CameraDevice.front,
                            // Thêm các options để đảm bảo chỉ dùng camera trước
                            imageQuality: 80, // Có thể điều chỉnh chất lượng ảnh
                          );

                          if (photo != null) {
                            await controller.saveFaceImage(photo.path);
                          } else {
                            // Người dùng đã hủy chụp ảnh
                            TLoaders.warningSnackBar(
                              title: 'No Photo Taken',
                              message: 'Please take a photo with front camera',
                            );
                          }
                        } catch (e) {
                          // Xử lý lỗi khi không thể mở camera
                          TLoaders.errorSnackBar(
                            title: 'Camera Error',
                            message: 'Could not access front camera. Please try again.',
                          );
                        }
                      },
                      child: Container(
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
                    const Expanded(child: SizedBox()), // Replace Spacer with Expanded
                    // Button Next
                    TBottomButton(
                      onPressed: () {
                        if (controller.faceImage.value == null) {
                          TLoaders.errorSnackBar(
                            title: 'No Image',
                            message: 'Please take a photo first',
                          );
                          return;
                        }
                        controller.saveFaceImage(controller.faceImage.value!);
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
