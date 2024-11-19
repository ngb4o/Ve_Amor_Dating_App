import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/user_controller.dart';

class TProfileAddPhoto extends StatelessWidget {
  const TProfileAddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.clear, size: 30, color: TColors.primary),
        ),
      ),
      body: SizedBox(
        width: THelperFunctions.screenWidth(),
        height: THelperFunctions.screenHeight(),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.createNew, style: Theme.of(context).textTheme.headlineMedium),
              Text(TTexts.selectImage, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: TSizes.spaceBtwSections),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItems),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        if (image != null) {
                          CroppedFile? croppedFile = await ImageCropper().cropImage(
                            sourcePath: image.path,
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: TColors.primary,
                                toolbarWidgetColor: Colors.white,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.square,
                                ],
                              ),
                            ],
                            aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
                          );
                          if (croppedFile != null) {
                            Navigator.pop(context);
                            await controller.pushImageFirebase(croppedFile.path);
                          }
                        }
                      },
                      child: Container(
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
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 80,
                        );
                        if (image != null) {
                          CroppedFile? croppedFile = await ImageCropper().cropImage(
                            sourcePath: image.path,
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: TColors.primary,
                                toolbarWidgetColor: Colors.white,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.square,
                                ],
                              ),
                            ],
                            aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
                          );
                          if (croppedFile != null) {
                            Navigator.pop(context);
                            await controller.pushImageFirebase(croppedFile.path);
                          }
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
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.white),
                              ),
                              Text(
                                TTexts.camera,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: TColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
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
