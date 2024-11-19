part of 'update_imports.dart';

class UpdatePhoneNumber extends StatelessWidget {
  const UpdatePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      appBar: const TAppbar(title: Text('Update Phone Number'), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Enter your phone number to ensure easy communication and verification. This number will be used for authentication and contact purposes.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Text field and button
            Form(
              key: controller.updateUserPhoneNumberFormKey,
              child: TextFormField(
                controller: controller.phoneNumberController,
                expands: false,
                validator: (value) => TValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
