part of 'widget_imports.dart';

class TSwipeCard extends StatelessWidget {
  final int currentPhoto;
  final int numberPhotos;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final bool heightWidthHomeDetail;
  final bool borderRadiusImage;
  final bool shadowImage;
  final String image;

  const TSwipeCard({
    super.key,
    required this.currentPhoto,
    required this.numberPhotos,
    required this.onLeftTap,
    required this.onRightTap,
    this.heightWidthHomeDetail = false,
    this.borderRadiusImage = true,
    this.shadowImage = true,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Cached Image
        Container(
          width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
          height: heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
          decoration: BoxDecoration(
            borderRadius: borderRadiusImage ? BorderRadius.circular(10) : null,
          ),
          child: ClipRRect(
            borderRadius: borderRadiusImage ? BorderRadius.circular(10) : BorderRadius.zero,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, url) => TShimmerEffect(
                width: THelperFunctions.screenWidth(),
                height: THelperFunctions.screenHeight(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
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
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: dark
                    ? [TColors.black, Colors.transparent]
                    : [TColors.primary.withOpacity(0.8), Colors.transparent],
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
                  height: heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
                  color: Colors.transparent,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onRightTap,
                child: Container(
                  width: heightWidthHomeDetail ? THelperFunctions.screenWidth() : null,
                  height: heightWidthHomeDetail ? (THelperFunctions.screenHeight() * 0.6) - 25 : null,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),

        // Image Navigation Dots
        TImageNavigationDots(currentPhoto: currentPhoto, numberPhotos: numberPhotos),
      ],
    );
  }
}
