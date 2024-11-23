part of 'widget_imports.dart';

class TChatEmpty extends StatelessWidget {
  const TChatEmpty({
    super.key,
    required this.name,
    required this.imagePath,
  });

  final String name;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(TTexts.titleChatEmpty,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: dark ? TColors.light.withOpacity(0.5) : TColors.dark.withOpacity(0.5))),
              Text('$name 🎉', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Image
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: imagePath,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
              placeholder: (context, url) => const TShimmerEffect(width: 130, height: 130),
              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Text(
            TTexts.subTitleChatEmpty,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
