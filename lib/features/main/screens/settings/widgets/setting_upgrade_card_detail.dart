part of 'widget_imports.dart';

class UpgradeCardDetailScreen extends StatelessWidget {
  final String subscriptionType;

  const UpgradeCardDetailScreen({Key? key, required this.subscriptionType})
      : super(key: key);

  Map<String, dynamic> getSubscriptionDetails(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    switch (subscriptionType) {
      case 'Plus':
        return {
          'title': 'VeAmor Plus',
          'description': 'Unlock unlimited likes and more!',
          'features': [
            'Unlimited Likes',
            'Unlimited Rewinds',
            'Passport',
            'Control your profile',
            'Control who sees you',
            'Control who you see',
            'Hide advertisements',
          ],
          'price': '5\$ / month',
          'gradientColors': [
            TColors.primary.withOpacity(0.8),
            Colors.pink.shade400
          ],
          'buttonColor': Colors.pink,
        };
      case 'Platinum':
        return {
          'title': 'VeAmor Platinum',
          'description': 'Get priority likes and advanced features!',
          'features': [
            'Unlimited Likes',
            'Unlimited Rewinds',
            'Passport',
            'Control your profile',
            'Control who sees you',
            'Control who you see',
            'Hide advertisements',
            'Top Picks',
            '3 Free Super Likes per Week',
            '1 Free Boost per Month',
            'Priority Likes',
            '3 Free First Impressions per Week',
            'Unlimited Passport Mode',
          ],
          'price': '10\$ / month',
          'gradientColors': [
            Colors.grey.shade500,
            Colors.grey.shade300
          ],
          'buttonColor': Colors.grey,
        };
      case 'Gold':
      default:
        return {
          'title': 'VeAmor Gold',
          'description': 'Enjoy premium features and top picks!',
          'features': [
            'Unlimited Likes',
            'Unlimited Rewinds',
            'Passport',
            'Control your profile',
            'Control who sees you',
            'Control who you see',
            'Hide advertisements',
            'Top Picks',
            '3 Free Super Likes per Week',
            '1 Free Boost per Month',
          ],
          'price': '15\$ / month',
          'gradientColors': [
            Colors.amber.shade600,
            Colors.amber.shade400
          ],
          'buttonColor': Colors.amber,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = getSubscriptionDetails(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(details['title']),
        backgroundColor: details['buttonColor'],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with Title, Description, and Price
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: details['gradientColors'],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details['title'],
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      details['description'],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      details['price'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Features List
              Text(
                'Features:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...details['features'].map<Widget>((feature) {
                return ListTile(
                  leading: Icon(Icons.check, color: details['buttonColor']),
                  title: Text(feature),
                );
              }).toList(),
              const SizedBox(height: 20),
              // Upgrade Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: details['buttonColor'],
                  minimumSize: const Size(double.infinity, 50), // Chiều rộng full và chiều cao cố định
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
                  ),
                ),
                onPressed: () {
                  // Xử lý nâng cấp gói
                },
                child: Text(
                  'Upgrade Now',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
