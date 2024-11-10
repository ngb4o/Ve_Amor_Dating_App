part of 'profile_imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    List<String> newPhotos = [];

    // Delete account warning
    void deleteAccountWarningPopup() {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permanently ? '
            'This action is not reversible and all of your data will be removed permanently',
        confirm: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
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
              SizedBox(
                width: THelperFunctions.screenWidth(),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (!(newPhotos.isNotEmpty && (index < newPhotos.length))) {
                          var photos = await pushScreen(
                            context,
                            screen: const TProfileAddPhoto(),
                            pageTransitionAnimation: PageTransitionAnimation.slideUp,
                            withNavBar: false,
                          );

                          if (photos != null && photos is Iterable<String>) {
                            setState(() {
                              newPhotos.addAll(photos);
                            });
                          }
                        }
                      },
                      child: Stack(
                        children: [
                          // List Image
                          Padding(
                            padding: const EdgeInsets.all(TSizes.xs),
                            child: newPhotos.isNotEmpty && (index < newPhotos.length)
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(File(newPhotos[index])),
                                      ),
                                    ),
                                  )
                                : DottedBorder(
                                    color: dark ? Colors.white : Colors.grey.shade700,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(8),
                                    dashPattern: const [6, 6, 6, 6],
                                    padding: EdgeInsets.zero,
                                    strokeWidth: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                          ),

                          // Add Button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: Center(
                                  child: newPhotos.isNotEmpty && (index < newPhotos.length)
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              newPhotos.remove(newPhotos[index]);
                                            });
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.grey),
                                                color: TColors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(TSizes.xs),
                                              child: Image.asset(
                                                'assets/icons/home/clear.png',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: TColors.primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(TSizes.xs),
                                            child: Image.asset(
                                              'assets/icons/home/add.png',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),


              // Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Profile Infor
              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Name', value: 'Nguyen Gia Bao', onTap: () {}),
              TProfileMenu(title: 'Age', value: '21', onTap: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Heading Personal Infor
              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Email
              TProfileMenu(title: 'E-mail', value: 'ngbao08052003@gmail.com', onTap: () {}),

              // Phone number
              TProfileMenu(title: 'Phone Number', value: '0962492787', onTap: () {}),

              // Gender
              TProfileMenu(title: 'Gender', value: 'Male', onTap: () {}),

              // Date Of Birth
              TProfileMenu(title: 'Date of Birth', value: '8 May, 2003', onTap: () {}),
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
