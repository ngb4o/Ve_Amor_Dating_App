part of 'profile_imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final controllerRemoveAccount = Get.put(RemoveAccountController());
    final dark = THelperFunctions.isDarkMode(context);

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

              // Address
              Obx(
                () => TProfileMenu(
                  title: 'Address',
                  value: controller.user.value.location?["address"],
                  onTap: () {},
                ),
              ),

              // Zodiac
              Obx(
                () => TProfileMenu(
                  title: 'Zodiac',
                  value: controller.user.value.zodiac,
                  onTap: () {},
                ),
              ),

              // Phone number
              Obx(
                () => TProfileMenu(
                  title: 'Phone',
                  value: controller.user.value.phoneNumber,
                  isUpdate: true,
                  onTap: () {
                    Get.to(() => const UpdatePhoneNumber());
                  },
                ),
              ),

              // Interested in
              Obx(
                () => TProfileMenu(
                  title: 'Interested in',
                  value: controller.user.value.wantSeeing,
                  isUpdate: true,
                  onTap: () {
                    final profileController = Get.put(UpdateProfileController());
                    Get.bottomSheet(
                      ProfileBottomSheet(
                        title: 'Interested in',
                        options: LifestyleOptions.interestedInOptions,
                        isMultiSelect: false,
                        selectedValue: profileController.selectedWantSeeing,
                        onOptionSelected: (option) => profileController.selectedWantSeeing.value = option,
                        onSave: () => profileController.updateWantSeeing(),
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),

              // Looking for
              Obx(
                () => TProfileMenu(
                  title: 'Looking for',
                  value: controller.user.value.findingRelationship,
                  isUpdate: true,
                  onTap: () {
                    final profileController = Get.put(UpdateProfileController());
                    Get.bottomSheet(
                      ProfileBottomSheet(
                        title: 'Looking for',
                        options: LifestyleOptions.lookingForOptions,
                        isMultiSelect: false,
                        selectedValue: profileController.selectedFindingRelationship,
                        onOptionSelected: (option) =>
                            profileController.selectedFindingRelationship.value = option,
                        onSave: () => profileController.updateFindingRelationship(),
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),

              // Sports
              Obx(
                () => TProfileMenu(
                  title: 'Sports',
                  value: controller.user.value.sports.join(', '),
                  isUpdate: true,
                  onTap: () {
                    final profileController = Get.put(UpdateProfileController());
                    Get.bottomSheet(
                      ProfileBottomSheet(
                        title: 'Sports',
                        options: LifestyleOptions.sportsOptions,
                        isMultiSelect: true,
                        selectedValue: profileController.selectedSports,
                        onOptionSelected: (sport) => profileController.toggleSelection(
                          sport,
                          profileController.selectedSports,
                        ),
                        onSave: () => profileController.updateSports(),
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),

              // Pets
              Obx(
                () => TProfileMenu(
                  title: 'Pets',
                  value: controller.user.value.pets.join(', '),
                  isUpdate: true,
                  onTap: () {
                    final profileController = Get.put(UpdateProfileController());
                    Get.bottomSheet(
                      ProfileBottomSheet(
                        title: 'Pets',
                        options: LifestyleOptions.petsOptions,
                        isMultiSelect: true,
                        selectedValue: profileController.selectedPets,
                        onOptionSelected: (pet) => profileController.toggleSelection(
                          pet,
                          profileController.selectedPets,
                        ),
                        onSave: () => profileController.updatePets(),
                      ),
                      isScrollControlled: true,
                    );
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
