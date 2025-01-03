part of 'widget_imports.dart';

class UpgradeCardDetailScreen extends StatefulWidget {
  final String subscriptionType;
  final int index;
  final bool onlyOne;

  const UpgradeCardDetailScreen(
      {Key? key, required this.subscriptionType, required this.index, this.onlyOne = false})
      : super(key: key);

  @override
  _UpgradeCardDetailScreenState createState() => _UpgradeCardDetailScreenState();
}

class _UpgradeCardDetailScreenState extends State<UpgradeCardDetailScreen> {
  late Map<String, dynamic> details;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.index;
    details = getSubscriptionDetails(widget.subscriptionType);
  }

  // Hàm lấy thông tin chi tiết của gói đăng ký
  Map<String, dynamic> getSubscriptionDetails(String subscriptionType) {
    switch (subscriptionType) {
      case 'Plus':
        return {
          'title': 'VeAmor Plus',
          'description': 'Unlock unlimited likes, rewinds, and passport to meet people anywhere.',
          'features': {
            'Upgrade Your Likes': [
              {'name': 'Unlimited Likes', 'locked': false},
              {'name': 'See Who Likes You', 'locked': true}, // Biểu tượng khóa cho Plus
              {'name': 'Priority Likes', 'locked': true}, // Biểu tượng khóa cho Plus
            ],
            'Enhance Your Experience': [
              {'name': 'Unlimited Rewinds', 'locked': false},
              {'name': '1 Free Boost per Month', 'locked': true}, // Biểu tượng khóa cho Plus
              {'name': '3 Free Super Likes per Week', 'locked': true}, // Biểu tượng khóa cho Plus
              {'name': '3 First Impressions/Week', 'locked': true}, // Biểu tượng khóa cho Plus
            ],
            'Premium Discovery': [
              {'name': 'Unlimited Passport Mode', 'locked': false},
              {'name': 'Top Picks', 'locked': true}, // Biểu tượng khóa cho Plus
            ],
            'Take Control': [
              {'name': 'Control Your Profile', 'locked': false},
              {'name': 'Control Who Sees You', 'locked': false},
              {'name': 'Control Who You See', 'locked': false},
              {'name': 'Hide Ads', 'locked': false},
            ],
          },
          'color': TColors.primary,
          'gradientColors': [TColors.primary.withOpacity(0.8), Colors.white],
          'price': '39.000'
        };
      case 'Platinum':
        return {
          'title': 'VeAmor Platinum',
          'description': 'Get priority likes and exclusive features to see who likes you.',
          'features': {
            'Upgrade Your Likes': [
              {'name': 'Unlimited Likes', 'locked': false},
              {'name': 'See Who Likes You', 'locked': false}, // Tất cả đều có cho Platinum
              {'name': 'Priority Likes', 'locked': false}, // Tất cả đều có cho Platinum
            ],
            'Enhance Your Experience': [
              {'name': 'Unlimited Rewinds', 'locked': false},
              {'name': '1 Free Boost per Month', 'locked': false},
              {'name': '3 Free Super Likes per Week', 'locked': false},
              {'name': '3 First Impressions/Week', 'locked': false},
            ],
            'Premium Discovery': [
              {'name': 'Unlimited Passport Mode', 'locked': false},
              {'name': 'Top Picks', 'locked': false},
            ],
            'Take Control': [
              {'name': 'Control Your Profile', 'locked': false},
              {'name': 'Control Who Sees You', 'locked': false},
              {'name': 'Control Who You See', 'locked': false},
              {'name': 'Hide Ads', 'locked': false},
            ],
          },
          'color': Colors.grey,
          'gradientColors': [Colors.grey.shade500, Colors.white],
          'price': '149.000'
        };
      case 'Gold':
      default:
        return {
          'title': 'VeAmor Gold',
          'description': 'See who likes you and enjoy top picks with free super likes.',
          'features': {
            'Upgrade Your Likes': [
              {'name': 'Unlimited Likes', 'locked': false},
              {'name': 'See Who Likes You', 'locked': false}, // Tất cả đều có cho Gold
              {'name': 'Priority Likes', 'locked': true}, // Biểu tượng khóa cho Gold
            ],
            'Enhance Your Experience': [
              {'name': 'Unlimited Rewinds', 'locked': false},
              {'name': '1 Free Boost per Month', 'locked': false},
              {'name': '3 Free Super Likes per Week', 'locked': false},
              {'name': '3 First Impressions/Week', 'locked': true}, // Biểu tượng khóa cho Gold
            ],
            'Premium Discovery': [
              {'name': 'Unlimited Passport Mode', 'locked': false},
              {'name': 'Top Picks', 'locked': true}, // Biểu tượng khóa cho Gol
            ],
            'Take Control': [
              {'name': 'Control Your Profile', 'locked': false},
              {'name': 'Control Who Sees You', 'locked': false},
              {'name': 'Control Who You See', 'locked': false},
              {'name': 'Hide Ads', 'locked': false},
            ],
          },
          'color': Colors.amber,
          'gradientColors': [Colors.amber.shade400, Colors.white],
          'price': '69.000'
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: details['gradientColors'],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const TAppbar(
                showBackArrow: true,
                colorBackArrow: Colors.white,
              ),
              SizedBox(
                height: 250,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                      // Cập nhật lại thông tin chi tiết gói khi cuộn trang
                      details = getSubscriptionDetails(index == 0
                          ? 'Plus'
                          : index == 1
                              ? 'Gold'
                              : 'Platinum');
                    });
                  },
                  children: widget.onlyOne
                      ? [
                          _buildSubscriptionCard('Plus', Colors.blueAccent, _currentPage),
                        ]
                      : [
                          _buildSubscriptionCard('Plus', Colors.blueAccent, _currentPage),
                          _buildSubscriptionCard('Gold', Colors.blueAccent, _currentPage),
                          _buildSubscriptionCard('Platinum', Colors.black45, _currentPage),
                        ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: widget.onlyOne
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            width: _currentPage == index ? 12.0 : 8.0,
                            height: _currentPage == index ? 12.0 : 8.0,
                            decoration: BoxDecoration(
                              color: _currentPage == index ? Colors.black : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    right: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureSection(
                        'Upgrade Your Likes', details['features']['Upgrade Your Likes']),
                    _buildFeatureSection(
                        'Enhance Your Experience', details['features']['Enhance Your Experience']),
                    _buildFeatureSection(
                        'Premium Discovery', details['features']['Premium Discovery']),
                    _buildFeatureSection('Take Control', details['features']['Take Control']),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: details['color'],
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            ),
                            side: BorderSide(
                              color: details['color'],
                              width: 2.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                subscriptionType: details['title'],
                                price: details['price'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Starting at ₫${details['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(String subscriptionType, Color color, int index) {
    // Determine the subscription type based on the index
    switch (index) {
      case 0:
        subscriptionType = 'Plus';
        break;
      case 1:
        subscriptionType = 'Gold';
        break;
      case 2:
        subscriptionType = 'Platinum';
        break;
      default:
        subscriptionType = 'Gold'; // Default case
    }

    return GestureDetector(
      onTap: () {
        Get.to(
          () => UpgradeCardDetailScreen(
            subscriptionType: subscriptionType, // Pass the determined subscriptionType
            index: index,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: SubscriptionCard(subscriptionType: subscriptionType),
      ),
    );
  }

  Widget _buildFeatureSection(String title, List<Map<String, dynamic>> features) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                children: [
                  feature['locked']
                      ? const Icon(Icons.lock_outline, color: Colors.black45)
                      : const Icon(Icons.check, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(feature['name']),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
