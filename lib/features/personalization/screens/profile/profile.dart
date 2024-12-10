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
                  onTap: () {
                    final lifestyleController = Get.put(UpdateLifestyleController());
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header bar indicator
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: TSizes.md),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(TSizes.xs),
                              ),
                            ),

                            // Title
                            Text(
                              'Zodiac',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Zodiac options
                            Obx(() => Wrap(
                                  spacing: TSizes.xs,
                                  runSpacing: TSizes.xs,
                                  children: [
                                    'Aries (Mar 21 - Apr 19)',
                                    'Taurus (Apr 20 - May 20)',
                                    'Gemini (May 21 - Jun 20)',
                                    'Cancer (Jun 21 - Jul 22)',
                                    'Leo (Jul 23 - Aug 22)',
                                    'Virgo (Aug 23 - Sep 22)',
                                    'Libra (Sep 23 - Oct 22)',
                                    'Scorpio (Oct 23 - Nov 21)',
                                    'Sagittarius (Nov 22 - Dec 21)',
                                    'Capricorn (Dec 22 - Jan 19)',
                                    'Aquarius (Jan 20 - Feb 18)',
                                    'Pisces (Feb 19 - Mar 20)',
                                  ]
                                      .map((zodiac) => FilterChip(
                                            label: Text(zodiac),
                                            selected: lifestyleController.selectedZodiac.value == zodiac,
                                            onSelected: (_) {
                                              lifestyleController.selectedZodiac.value = zodiac;
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            selectedColor: TColors.primary,
                                            labelStyle: TextStyle(
                                              color: lifestyleController.selectedZodiac.value == zodiac
                                                  ? TColors.white
                                                  : TColors.black,
                                            ),
                                          ))
                                      .toList(),
                                )),
                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Done button
                            TBottomButton(
                              onPressed: () => lifestyleController.updateZodiac(),
                              textButton: 'Done',
                            ),
                            const SizedBox(height: TSizes.defaultSpace),
                          ],
                        ),
                      ),
                      isScrollControlled: true,
                    );
                  },
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
                    final preferencesController = Get.put(UpdatePreferencesController());
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header bar indicator
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: TSizes.md),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(TSizes.xs),
                              ),
                            ),

                            // Title
                            Text(
                              'Interested in',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Options
                            Obx(
                              () => Wrap(
                                spacing: TSizes.xs,
                                runSpacing: TSizes.xs,
                                children: [
                                  'Men',
                                  'Women',
                                  'Everyone',
                                ]
                                    .map((option) => FilterChip(
                                          label: Text(option),
                                          selected: preferencesController.selectedWantSeeing.value == option,
                                          onSelected: (_) {
                                            preferencesController.selectedWantSeeing.value = option;
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          selectedColor: TColors.primary,
                                          labelStyle: TextStyle(
                                            color: preferencesController.selectedWantSeeing.value == option
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),

                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Done button
                            TBottomButton(
                              onPressed: () => preferencesController.updateWantSeeing(),
                              textButton: 'Done',
                            ),
                            const SizedBox(height: TSizes.defaultSpace),
                          ],
                        ),
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
                    final preferencesController = Get.put(UpdatePreferencesController());
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header bar indicator
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: TSizes.md),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(TSizes.xs),
                              ),
                            ),

                            // Title
                            Text(
                              'Looking for',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Options
                            Obx(
                              () => Wrap(
                                spacing: TSizes.xs,
                                runSpacing: TSizes.xs,
                                children: [
                                  'Lover',
                                  'A long-term dating partner',
                                  'Anything that might happen',
                                  'A casual relationship',
                                  'New friends',
                                  'I\'m not sure yet',
                                ]
                                    .map((option) => FilterChip(
                                          label: Text(option),
                                          selected: preferencesController.selectedFindingRelationship.value ==
                                              option,
                                          onSelected: (_) {
                                            preferencesController.selectedFindingRelationship.value = option;
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          selectedColor: TColors.primary,
                                          labelStyle: TextStyle(
                                            color: preferencesController.selectedFindingRelationship.value ==
                                                    option
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),

                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Done button
                            TBottomButton(
                              onPressed: () => preferencesController.updateFindingRelationship(),
                              textButton: 'Done',
                            ),
                            const SizedBox(height: TSizes.defaultSpace),
                          ],
                        ),
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
                    final lifestyleController = Get.put(UpdateLifestyleController());
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header bar indicator
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: TSizes.md),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(TSizes.xs),
                              ),
                            ),

                            // Title
                            Text(
                              'Sports',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Sports options
                            Obx(
                              () => Wrap(
                                spacing: TSizes.xs,
                                runSpacing: TSizes.xs,
                                children: [
                                  'Pickleball',
                                  'Paddle Tennis',
                                  'Esports',
                                  'Soccer',
                                  'Basketball',
                                  'Tennis',
                                  'Cricket',
                                  'Golf',
                                  'Baseball',
                                  'Running',
                                  'Cycling',
                                  'Volleyball',
                                  'Yoga',
                                  'Gym',
                                  'Swimming',
                                  'Boxing',
                                  'MMA'
                                ]
                                    .map((sport) => FilterChip(
                                          label: Text(sport),
                                          selected: lifestyleController.selectedSports.contains(sport),
                                          onSelected: (_) {
                                            lifestyleController.toggleSelection(
                                              sport,
                                              lifestyleController.selectedSports,
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          selectedColor: TColors.primary,
                                          labelStyle: TextStyle(
                                            color: lifestyleController.selectedSports.contains(sport)
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),

                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Done button
                            TBottomButton(
                              onPressed: () => lifestyleController.updateSports(),
                              textButton: 'Done',
                            ),
                          ],
                        ),
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
                    final lifestyleController = Get.put(UpdateLifestyleController());
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            topRight: Radius.circular(TSizes.md),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header bar indicator
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: TSizes.md),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(TSizes.xs),
                              ),
                            ),

                            // Title
                            Text(
                              'Pets',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Pets options
                            Obx(
                              () => Wrap(
                                spacing: TSizes.xs,
                                runSpacing: TSizes.xs,
                                children: [
                                  'Dog',
                                  'Cat',
                                  'Fish',
                                  'Rabbit',
                                  'Hamster',
                                  'Turtle',
                                  'No pets',
                                  'Allergic to animals',
                                  'All kinds of pets',
                                  'Others'
                                ]
                                    .map((pet) => FilterChip(
                                          label: Text(pet),
                                          selected: lifestyleController.selectedPets.contains(pet),
                                          onSelected: (_) {
                                            lifestyleController.toggleSelection(
                                              pet,
                                              lifestyleController.selectedPets,
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          selectedColor: TColors.primary,
                                          labelStyle: TextStyle(
                                            color: lifestyleController.selectedPets.contains(pet)
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),

                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Done button
                            TBottomButton(
                              onPressed: () => lifestyleController.updatePets(),
                              textButton: 'Done',
                            ),
                            const SizedBox(height: TSizes.defaultSpace),
                          ],
                        ),
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
