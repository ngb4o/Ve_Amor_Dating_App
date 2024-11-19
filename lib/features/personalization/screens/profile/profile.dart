part of 'profile_imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final controllerRemoveAccount = Get.put(RemoveAccountController());

    // Delete account warning
    void deleteAccountWarningPopup() {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permanently ? '
            'This action is not reversible and all of your data will be removed permanently',
        confirm: ElevatedButton(
          onPressed: () {
            controllerRemoveAccount.deleteUserAccount();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
        ),
        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
        ),
      );
    }

    return Scaffold(
      appBar: const TAppbar(
        title: Text('Profile'),
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              const TSectionHeading(title: 'Photos', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // List Photo
              const TProFilePhoto(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Profile Information
              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(
                () => TProfileMenu(
                  title: 'Name',
                  value: controller.user.value.username,
                  onTap: () {},
                ),
              ),
              Obx(
                    () => TProfileMenu(
                  title: 'Age',
                  value: controller.user.value.age.toString(), // Lấy tuổi từ getter
                  onTap: () {},
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Personal Information
              const TSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Gender
              Obx(
                () => TProfileMenu(
                  title: 'Gender',
                  value: controller.user.value.gender,
                  onTap: () {},
                ),
              ),

              // Date Of Birth
              Obx(
                () => TProfileMenu(
                  title: 'Date of Birth',
                  value: controller.user.value.dateOfBirth,
                  onTap: () {},
                ),
              ),

              // Email
              Obx(
                () => TProfileMenu(
                  title: 'E-mail',
                  value: controller.user.value.email,
                  isUpdate: false,
                  onTap: () {},
                ),
              ),

              // Phone number
              Obx(
                () => TProfileMenu(
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber,
                  isUpdate: true,
                  onTap: () {
                    Get.to(() => const UpdatePhoneNumber());
                  },
                ),
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: deleteAccountWarningPopup,
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
