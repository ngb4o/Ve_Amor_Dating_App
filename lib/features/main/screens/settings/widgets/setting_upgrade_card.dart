part of 'widget_imports.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionType;

  const SubscriptionCard({
    super.key,
    required this.subscriptionType,
  });

  Map<String, dynamic> getSubscriptionDetails(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    switch (subscriptionType) {
      case 'Plus':
        return {
          'color': Colors.pink,
          'iconColor': TColors.primary,
          'badgeText': 'PLUS',
          'gradientStartColor': TColors.primary.withOpacity(0.8),
          'gradientEndColor': Colors.white,
          'borderColor': TColors.primary,
          'featureColor': TColors.primary,
          'textColor': Colors.black,
          'textFeatureColor': Colors.white,
          'buttonGradientStartColor': TColors.primary,
          'buttonGradientEndColor': Colors.pink.shade400,
          'textFeature1' : 'Unlimited Likes',
          'textFeature2' : 'Unlimited Rewinds',
          'textFeature3' : 'Passport',
        };
      case 'Platinum':
        return {
          'color': Colors.grey,
          'iconColor': TColors.black,
          'badgeText': 'PLATINUM',
          'gradientStartColor': Colors.grey.shade500,
          'gradientEndColor': Colors.white,
          'borderColor': Colors.black,
          'featureColor': Colors.black.withOpacity(0.7),
          'textColor': isDarkMode ? Colors.black : Colors.black,
          'textFeatureColor': Colors.white,
          'buttonGradientStartColor': Colors.black,
          'buttonGradientEndColor': Colors.black.withOpacity(0.5),
          'textFeature1' : 'Priority Likes',
          'textFeature2' : 'Message Before Matching',
          'textFeature3' : 'See Who Likes You',
        };
      case 'Gold':
      default:
        return {
          'color': Colors.amber,
          'iconColor': Colors.amber.shade800,
          'badgeText': 'GOLD',
          'gradientStartColor': Colors.amber.shade200,
          'gradientEndColor': Colors.white,
          'borderColor': Colors.amber[500],
          'featureColor': Colors.amber.shade500,
          'textColor': Colors.black,
          'buttonGradientStartColor': Colors.amber.shade600,
          'buttonGradientEndColor': Colors.amber.shade400,
          'textFeature1' : 'See Who Likes You',
          'textFeature2' : 'Top Picks',
          'textFeature3' : 'Free Super Likes',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = getSubscriptionDetails(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15),
      child: Container(
        width: 385,
        decoration: BoxDecoration(
          border: Border.all(color: details['borderColor']),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [details['gradientStartColor'], details['gradientEndColor']],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: details['iconColor'],
                        size: 30,
                      ),
                      Text(
                        'VeAmor ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: details['textColor'],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: details['featureColor'],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          details['badgeText'],
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: details['textFeatureColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: [
                          details['buttonGradientStartColor'],
                          details['buttonGradientEndColor']
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.center,
                      ),
                    ),
                    child: Text(
                      'Upgrade',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: details['textFeatureColor'],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Included Features',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: details['textColor'],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(details['textFeature1'], style: TextStyle(color: details['textColor'])),
                  Icon(Icons.check, color: details['textColor']),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(details['textFeature2'], style: TextStyle(color: details['textColor'])),
                  Icon(Icons.check, color: details['textColor']),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(details['textFeature3'], style: TextStyle(color: details['textColor'])),
                  Icon(Icons.check, color: details['textColor']),
                ],
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => UpgradeCardDetailScreen(subscriptionType: subscriptionType));
                  },
                  child: Text(
                    'See all features',
                    style: TextStyle(
                      color: details['textColor'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
