part of 'widget_imports.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TAppbar(
      title: Row(
        children: [
          Image.asset(
            width: 50,
            height: 70,
            dark
                ? 'assets/logos/t-store-splash-logo-white.png'
                : 'assets/logos/t-store-splash-logo-black.png',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.homeAppbarTitle,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.iconNavigation),
              ),
              Text(
                TTexts.appName,
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.iconNavigation),
              )
            ],
          ),
        ],
      ),
      actions: [
        TNotifiCounterIcon(
          iconColor: dark ? TColors.grey : TColors.black.withOpacity(0.7),
          onPressed: () {},
        )
      ],
    );
  }
}