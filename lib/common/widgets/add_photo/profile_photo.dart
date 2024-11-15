import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ve_amor_app/features/authentication/controller/initial_information/initial_information_controller.dart';
import 'package:ve_amor_app/features/main/screens/profile/widgets/widget_imports.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

class TProFilePhoto extends StatelessWidget {
  const TProFilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = InitialInformationController.instance;

    return SizedBox(
      width: THelperFunctions.screenWidth(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 9 / 16,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              if (!(controller.newPhotos.isNotEmpty && (index < controller.newPhotos.length))) {
                var photos = await pushScreen(
                  context,
                  screen: const TProfileAddPhoto(),
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  withNavBar: false,
                );

                if (photos != null && photos is Iterable<String>) {
                  controller.addPhotos(photos.toList());
                }
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.xs),
                  child: controller.newPhotos.isNotEmpty && (index < controller.newPhotos.length)
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(File(controller.newPhotos[index])),
                            ),
                          ),
                        )
                      : DottedBorder(
                          color: dark ? Colors.white : Colors.grey.shade700,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          dashPattern: const [6, 6, 6, 6],
                          padding: EdgeInsets.zero,
                          strokeWidth: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Center(
                        child:
                            controller.newPhotos.isNotEmpty && (index < controller.newPhotos.length)
                                ? GestureDetector(
                                    onTap: () {
                                      controller.removePhoto(index);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey),
                                          color: TColors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(TSizes.xs),
                                        child: Image.asset(
                                          'assets/icons/home/clear.png',
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: TColors.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(TSizes.xs),
                                      child: Image.asset(
                                        'assets/icons/home/add.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
