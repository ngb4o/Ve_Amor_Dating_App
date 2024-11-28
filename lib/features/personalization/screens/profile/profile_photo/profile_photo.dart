import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ve_amor_app/features/personalization/screens/profile/profile_photo/profile_add_photo.dart';

import '../../../../../../common/widgets/loaders/shimmer.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/user_controller.dart';

class TProFilePhoto extends StatelessWidget {
  const TProFilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = UserController.instance;

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
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.xs),
                  child: Obx(
                    () {
                      // Hiển thị hiệu ứng loading khi thêm ảnh
                      if (controller.imageUploading.value && index == controller.newPhotos.length) {
                        return const TShimmerEffect(
                          width: double.infinity,
                          height: double.infinity,
                          radius: 8,
                        );
                      }
                      // Hiển thị hiệu ứng loading khi xóa ảnh
                      if (controller.deletingIndex.value == index) {
                        return const TShimmerEffect(
                          width: double.infinity,
                          height: double.infinity,
                          radius: 8,
                        );
                      }
                      // Hiển thị ảnh hoặc vùng thêm ảnh
                      return controller.newPhotos.isNotEmpty && index < controller.newPhotos.length
                          ? Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: controller.newPhotos[index],
                                  progressIndicatorBuilder: (context, url, progress) => const TShimmerEffect(
                                    width: double.infinity,
                                    height: double.infinity,
                                    radius: 8,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error, color: TColors.primary),
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
                                  color: dark ? Colors.grey.shade700 :Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                    },
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
                        child: Obx(() {
                          return controller.newPhotos.isNotEmpty && index < controller.newPhotos.length
                              ? GestureDetector(
                                  onTap: () {
                                    if (controller.newPhotos.length > 2) {
                                      controller.deleteImage(controller.newPhotos[index], index);
                                    }
                                  },
                                  child: controller.newPhotos.length > 2
                                      ? Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.grey),
                                            color: TColors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(TSizes.xs),
                                            child: Image.asset(
                                              'assets/icons/home/clear.png',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(), // Không hiển thị gì nếu số ảnh <= 2
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
                                );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
