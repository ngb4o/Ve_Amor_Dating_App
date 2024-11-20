part of 'widget_imports.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;
    return Positioned(
      right: TSizes.defaultSpace + 2,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: dark ? TColors.primary : TColors.primary,
        ),
        onPressed: () {
          controller.nextPage();
        },
        child: const Icon(Iconsax.arrow_right_3, color: TColors.white,),
      ),
    );
  }
}
