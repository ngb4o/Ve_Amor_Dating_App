part of 'widget_imports.dart';

class THomeSwipeCard extends StatefulWidget {
  const THomeSwipeCard({super.key});

  @override
  State<THomeSwipeCard> createState() => _THomeSwipeCardState();
}

class _THomeSwipeCardState extends State<THomeSwipeCard> {
  final _controller = PageController(initialPage: 0);

  int numberPhotos = 4;
  int currentPhoto = 0;
  late MatchEngine _matchEngine;

  List<SwipeItem> items = [
    SwipeItem(
      content: 'Yogurt',
      likeAction: () {
        print('Like');
      },
      nopeAction: () {
        print('Nope');
      },
      superlikeAction: () {
        print('Super Like');
      },
      onSlideUpdate: (SlideRegion? region) async {
        print('Region $region');
      },
    ),
    SwipeItem(
      content: 'Nhi',
      likeAction: () {
        print('Like');
      },
      nopeAction: () {
        print('Nope');
      },
      superlikeAction: () {
        print('Super Like');
      },
      onSlideUpdate: (SlideRegion? region) async {
        print('Region $region');
      },
    ),
    SwipeItem(
      content: 'Bong',
      likeAction: () {
        print('Like');
      },
      nopeAction: () {
        print('Nope');
      },
      superlikeAction: () {
        print('Super Like');
      },
      onSlideUpdate: (SlideRegion? region) async {
        print('Region $region');
      },
    )
  ];

  @override
  void initState() {
    _matchEngine = MatchEngine(swipeItems: items);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SwipeCards(
      matchEngine: _matchEngine,
      upSwipeAllowed: true,
      onStackFinished: () {},
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 20),
          child: SizedBox(
            width: THelperFunctions.screenWidth(),
            height: THelperFunctions.screenHeight(),
            child: Hero(
              tag: 'imageTage$index',
              child: Stack(
                children: [
                  // Image
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/content/image-girl.png'),
                      ),
                    ),
                  ),

                  // Shadow
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          TColors.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

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
                                width: ((THelperFunctions.screenWidth() - (20 + ((numberPhotos + 1) * 8))) /
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

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Information
                              Row(
                                children: [
                                  // Name
                                  Text(
                                    items[index].content,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: TColors.white),
                                  ),

                                  const SizedBox(width: 10),

                                  // Age
                                  const Text('20', style: TextStyle(fontSize: 25, color: TColors.white)),
                                ],
                              ),

                              // Icon Detail Information
                              IconButton(
                                onPressed: () {
                                  pushScreen(
                                    context,
                                    pageTransitionAnimation: PageTransitionAnimation.slideUp,
                                    withNavBar: false,
                                    screen: THomeDetailInformation(index),
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.info_circle_fill,
                                  color: TColors.white,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.md),

                        // Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                splashColor: Colors.orange,
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: Colors.orange)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/icons/home/back.png',
                                        color: Colors.yellow,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.red,
                                onTap: () {
                                  _matchEngine.currentItem!.nope();
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: Colors.red)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/icons/home/clear.png',
                                        color: Colors.red,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  _matchEngine.currentItem!.superLike();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: Colors.blue)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/icons/home/star.png',
                                        color: Colors.blue,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  _matchEngine.currentItem!.like();
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: Colors.green)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/icons/home/heart.png',
                                        color: Colors.green,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                splashColor: Colors.purple,
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: Colors.purple)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/icons/home/light.png',
                                        color: Colors.purple,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
