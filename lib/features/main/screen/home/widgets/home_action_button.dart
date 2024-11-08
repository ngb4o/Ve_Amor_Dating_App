part of 'widget_imports.dart';

class TActionButtonRow extends StatelessWidget {
  final MatchEngine matchEngine;

  const TActionButtonRow({
    super.key,
    required this.matchEngine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TActionButton(
          assetPath: 'assets/icons/home/back.png',
          color: Colors.orangeAccent,
          size: 50,
          onTap: () {},
          hasBorder: false,
          hasElevation: true,
          hasBorderRadius: true,
          coloTransparent: false,
        ),
        TActionButton(
          assetPath: 'assets/icons/home/clear.png',
          color: Colors.red,
          size: 60,
          onTap: () => matchEngine.currentItem!.nope(),
          hasBorder: false,
          hasElevation: true,
          hasBorderRadius: true,
          coloTransparent: false,
        ),
        TActionButton(
          assetPath: 'assets/icons/home/star.png',
          color: Colors.blue,
          size: 50,
          onTap: () => matchEngine.currentItem!.superLike(),
          hasBorder: false,
          hasElevation: true,
          hasBorderRadius: true,
          coloTransparent: false,
        ),
        TActionButton(
          assetPath: 'assets/icons/home/heart.png',
          color: Colors.green,
          size: 60,
          onTap: () => matchEngine.currentItem!.like(),
          hasBorder: false,
          hasElevation: true,
          hasBorderRadius: true,
          coloTransparent: false,
        ),
        TActionButton(
          assetPath: 'assets/icons/home/light.png',
          color: Colors.purple,
          size: 50,
          onTap: () {},
          hasBorder: false,
          hasElevation: true,
          hasBorderRadius: true,
          coloTransparent: false,
        ),
      ],
    );
  }
}


