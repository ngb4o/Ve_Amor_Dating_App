part of 'widget_imports.dart';

class TMessageCard extends StatelessWidget {
  const TMessageCard({
    super.key,
    required this.imagePath,
    this.isVerify = false,
    this.isActive = true,
    required this.name,
    required this.message,
  });

  final String imagePath;
  final bool isVerify;
  final bool isActive;
  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: TSizes.sm),
        Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: TColors.primary.withOpacity(0.8),
                  backgroundImage: AssetImage(imagePath),
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
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
