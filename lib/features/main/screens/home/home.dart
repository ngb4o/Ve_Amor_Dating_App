part of 'home_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      body: Column(
        children: [

          // Appbar
          const THomeAppBar(),

          // Swipe Card
          Expanded(
            child: SwipeCards(
              matchEngine: _matchEngine,
              upSwipeAllowed: true,
              onStackFinished: () {},
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                  child: SizedBox(
                    width: THelperFunctions.screenWidth(),
                    height: THelperFunctions.screenHeight(),
                    child: Hero(
                      tag: 'imageTage$index',
                      child: Stack(
                        children: [

                          // Card
                          TSwipeCard(
                            currentPhoto: currentPhoto,
                            numberPhotos: numberPhotos,
                            onLeftTap: () {
                              if (currentPhoto > 0) setState(() => currentPhoto -= 1);
                            },
                            onRightTap: () {
                              if (currentPhoto < numberPhotos - 1) {
                                setState(() => currentPhoto += 1);
                              }
                            },
                          ),

                          // Dot Image Navigation
                          TImageNavigationDots(
                            currentPhoto: currentPhoto,
                            numberPhotos: numberPhotos,
                          ),

                          // Information
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: TInfoSection(
                                    content: items[index].content,
                                    index: index,
                                  ),
                                ),
                                const SizedBox(height: TSizes.md),

                                // Action Button
                                TActionButtonRow(matchEngine: _matchEngine)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
