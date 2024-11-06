part of 'widget_imports.dart';

class TImageNavigationDots extends StatelessWidget {
  final int currentPhoto;
  final int numberPhotos;

  const TImageNavigationDots({
    super.key,
    required this.currentPhoto,
    required this.numberPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SizedBox(
          width: THelperFunctions.screenWidth() - 20,
          height: 4,
          child: ListView.builder(
            itemCount: numberPhotos,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: ((THelperFunctions.screenWidth() - (20 + ((numberPhotos + 1) * 8))) /
                      numberPhotos),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: TColors.white, width: 0.5),
                    color: currentPhoto == index ? TColors.white : TColors.black.withOpacity(0.7),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
