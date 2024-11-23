part of 'widget_imports.dart';

class TMessageEmpty extends StatelessWidget {
  const TMessageEmpty({
    super.key,
    this.small = false,
  });

  final bool small;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: small ? null : MediaQuery.of(context).size.height - 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.layer5, size: small ? 50 : 100, color: TColors.primary),
            if (!small) ...[
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TTexts.titleMessageEmpty,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TTexts.subTitleMessageEmpty,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
