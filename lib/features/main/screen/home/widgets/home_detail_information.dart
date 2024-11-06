part of 'widget_imports.dart';

class THomeDetailInformation extends StatefulWidget {
  const THomeDetailInformation(this.index, {super.key});

  final int index;

  @override
  State<THomeDetailInformation> createState() => _THomeDetailInformationState();
}

class _THomeDetailInformationState extends State<THomeDetailInformation> {
  int numberPhotos = 4;
  int currentPhoto = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    // Image
                    SizedBox(
                      width: THelperFunctions.screenWidth(),
                      height: THelperFunctions.screenHeight() * 0.6,
                      child: Hero(
                        tag: 'imageTage${widget.index}',
                        child: Stack(
                          children: [
                            // Image
                            Container(
                              width: THelperFunctions.screenWidth(),
                              height: (THelperFunctions.screenHeight() * 0.6) - 25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/content/image-girl.png'),
                                ),
                              ),
                            ),

                            // Shadow
                            // Container(
                            //   width: THelperFunctions.screenWidth(),
                            //   height: (THelperFunctions.screenHeight() * 0.6) - 25,
                            //   decoration: const BoxDecoration(
                            //     gradient: LinearGradient(
                            //       begin: Alignment.bottomCenter,
                            //       end: Alignment.center,
                            //       colors: [
                            //         TColors.black,
                            //         Colors.transparent,
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            // Change Image
                            Row(
                              children: [
                                // Click Left
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (currentPhoto != 0) {
                                        setState(() {
                                          currentPhoto = currentPhoto - 1;
                                        });
                                        print('Left Click');
                                      }
                                    },
                                    child: Container(
                                      width: THelperFunctions.screenWidth(),
                                      height: (THelperFunctions.screenHeight() * 0.6) - 25,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),

                                // Click Right
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (currentPhoto < (numberPhotos - 1)) {
                                        setState(() {
                                          currentPhoto = currentPhoto + 1;
                                        });
                                        print('Right Click');
                                      }
                                    },
                                    child: Container(
                                      width: THelperFunctions.screenWidth(),
                                      height: (THelperFunctions.screenHeight() * 0.6) - 25,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Dot Image Navigation
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: SizedBox(
                                  width: THelperFunctions.screenWidth() - 20,
                                  height: 4,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: numberPhotos,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Container(
                                          width: ((THelperFunctions.screenWidth() -
                                                  (20 + ((numberPhotos + 1) * 8))) /
                                              numberPhotos),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: TColors.white,
                                                width: 0.5,
                                              ),
                                              color: currentPhoto == index
                                                  ? TColors.white
                                                  : TColors.black.withOpacity(0.7)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                            // Arrow Down
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Material(
                                  color: TColors.primary,
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(100),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icons/home/arrow_down.png',
                                            scale: 20,
                                            color: Colors.white,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                          child: Row(
                            children: [
                              // Name
                              Text(
                                'Yogurt',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: TColors.black),
                              ),
                              const SizedBox(width: 10),

                              // Age
                              const Text('20', style: TextStyle(fontSize: 25, color: TColors.black))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.placemark,
                                color: Colors.grey.shade600,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Đà Nẵng',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            "About Me",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                          child: Text(
                            "blabalbalblal\nbalbafzegzegizrio\ngnzgzuegfefzefhiuzehfzuehfuzefizehfozehofze\nzegfzeoifgjziejifnze",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Icon
            Positioned(
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                        splashColor: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          // _matchEngine.currentItem!.nope();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/home/clear.png',
                              color: Theme.of(context).colorScheme.primary,
                              fit: BoxFit.cover,
                            ),
                          )),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Material(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                        splashColor: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          // _matchEngine.currentItem!.superLike();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icons/home/star.png',
                              color: Colors.lightBlueAccent,
                              fit: BoxFit.cover,
                            ),
                          )),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Material(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                        onTap: () {
                          // _matchEngine.currentItem!.like();
                        },
                        splashColor: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/icons/home/heart.png',
                              color: Colors.greenAccent,
                              fit: BoxFit.cover,
                            ),
                          )),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
