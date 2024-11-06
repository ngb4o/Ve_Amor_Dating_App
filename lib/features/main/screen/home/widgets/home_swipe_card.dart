part of 'widget_imports.dart';

class TSwipeCard extends StatelessWidget {
  final int currentPhoto;
  final int numberPhotos;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final bool heightWidthHomeDetail;
  final bool borderRadiusImage;
  final bool shadowImage;

  const TSwipeCard({
    super.key,
    required this.currentPhoto,
    required this.numberPhotos,
    required this.onLeftTap,
    required this.onRightTap,
    this.heightWidthHomeDetail = false,
    this.borderRadiusImage = true,
    this.shadowImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        Container(
          width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
          height: heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
          decoration: BoxDecoration(
            borderRadius: borderRadiusImage ? BorderRadius.circular(10) : null,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/content/image-girl.png'),
            ),
          ),
        ),
        // Shadow
        if (shadowImage)
          Container(
            width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
            height: heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
            decoration: BoxDecoration(
              borderRadius: borderRadiusImage ? BorderRadius.circular(10) : null,
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [TColors.black, Colors.transparent],
              ),
            ),
          ),
        // Navigation
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onLeftTap,
                child: Container(
                  width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
                  height:
                      heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
                  color: Colors.transparent,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onRightTap,
                child: Container(
                  width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
                  height:
                      heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        TImageNavigationDots(currentPhoto: currentPhoto, numberPhotos: numberPhotos),
      ],
    );
  }
}