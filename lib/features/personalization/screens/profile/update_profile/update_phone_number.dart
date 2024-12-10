part of 'update_imports.dart';

class UpdatePhoneNumber extends StatelessWidget {
  const UpdatePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileController());
    return Scaffold(
      appBar: const TAppbar(
          title: Text('Update Phone Number'), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your phone number to ensure easy communication and verification.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(
              key: controller.updateProfileFormKey,
              child: TextFormField(
                controller: controller.phoneNumberController,
                validator: (value) => TValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(
                    labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePhoneNumber(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
