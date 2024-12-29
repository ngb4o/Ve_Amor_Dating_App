part of 'initial_information_imports.dart';

class InitialBirthdayPage extends StatelessWidget {
  const InitialBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = InitialInformationController.instance;

    return Scaffold(
      appBar: const TAppbar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TTexts.titleBirthday,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // TextField
            TextField(
              controller: controller.dateOfBirth,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép nhập số
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final text = newValue.text.replaceAll('/', ''); // Loại bỏ dấu `/` cũ
                  final buffer = StringBuffer();

                  for (int i = 0; i < text.length; i++) {
                    if (i == 2 || i == 4) buffer.write('/'); // Thêm dấu `/` sau ngày và tháng
                    buffer.write(text[i]);
                  }

                  return TextEditingValue(
                    text: buffer.toString(),
                    selection: TextSelection.collapsed(offset: buffer.length),
                  );
                }),
              ],
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.cake),
                hintText: 'D D / M M / Y Y Y Y',
                hintStyle: TextStyle(
                  color: dark ? TColors.grey.withOpacity(0.5) : TColors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Sub Title
            Text(TTexts.subTitleBirthday, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),

            // Button Next
            TBottomButton(
              onPressed: () => controller.saveBirthday(),
              textButton: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
