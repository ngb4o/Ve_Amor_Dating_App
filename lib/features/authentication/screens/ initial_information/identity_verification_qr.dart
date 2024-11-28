import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/common/widgets/appbar/appbar.dart';
import 'package:ve_amor_app/features/authentication/controller/initial_information/initial_information_controller.dart';
import 'package:ve_amor_app/navigation_menu.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/image_strings.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';
import 'package:ve_amor_app/utils/constants/text_strings.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/bottom_button/bottom_button.dart';

class InitialIdentityVerification extends StatelessWidget {
  InitialIdentityVerification({super.key});

  final controller = InitialInformationController.instance;

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('$barcodeScanRes');

      // Update the scanned code in GetX controller
      controller.updateScannedCode(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.titleIdentityVerification,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Sub Title
            Text(TTexts.subTitleIdentityVerification, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Camera
            GestureDetector(
              onTap: scanQR,
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

            const Spacer(),
            // Button Next
            TBottomButton(
              onPressed: () => Get.to(() => const NavigationMenu()),
              textButton: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
