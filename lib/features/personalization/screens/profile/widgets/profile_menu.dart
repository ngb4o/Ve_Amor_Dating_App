part of 'widget_imports.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.title,
    required this.value,
    required this.onTap,
    this.isUpdate = false,
  });

  final IconData icon;
  final String title, value;
  final VoidCallback onTap;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            isUpdate ? Expanded(child: Icon(icon, size: 18)) : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
