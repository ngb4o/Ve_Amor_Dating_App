part of 'widget_imports.dart';

class TMessageCard extends StatelessWidget {
  const TMessageCard({
    super.key,
    required this.imagePath,
    this.isVerify = false,
    this.isActive = true,
    required this.name,
    required this.message,
    this.isNetworkImage = true,
  });

  final String imagePath;
  final bool isVerify;
  final bool isActive;
  final String name;
  final String message;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: TSizes.sm),
        Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                    imageUrl: imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const TShimmerEffect(
                      width: 60,
                      height: 60,
                      radius: 30,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                  )
                      : Image.asset(
                    TImages.darkAppLogo,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isActive)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: TSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: TSizes.xs),
                      if (isVerify)
                        const Icon(
                          Icons.verified,
                          color: TColors.primary,
                          size: 16,
                        ),
                    ],
                  ),
                  const SizedBox(height: TSizes.xs),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems - 5),
        const Divider(),
      ],
    );
  }
}

