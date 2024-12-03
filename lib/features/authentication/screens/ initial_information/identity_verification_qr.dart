part of 'initial_information_imports.dart';

class InitialIdentityVerificationQRCode extends StatelessWidget {
  InitialIdentityVerificationQRCode({super.key});

  final controller = InitialInformationController.instance;

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      // Update the scanned code in GetX controller
      controller.updateScannedCode(barcodeScanRes);
      print(
          '-------------------------------------------- ${controller.scannedCode.value}');
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
              TTexts.titleIdentityVerificationQR,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Sub Title
            Text(TTexts.subTitleIdentityVerificationQR,
                style: Theme.of(context).textTheme.bodySmall),
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

            // Display scanned code
            Obx(() => controller.scannedCode.value.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Identity Number:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      Text(
                        controller.scannedCode.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : const SizedBox.shrink()),

            const Spacer(),

            // Button Next - Only show when scannedCode is not empty
            Obx(() => controller.scannedCode.value.isNotEmpty
                ? TBottomButton(
                    onPressed: () {
                      controller.saveIdentityVerificationQRCode();
                    },
                    textButton: 'Next',
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
