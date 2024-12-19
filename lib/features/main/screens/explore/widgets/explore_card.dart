part of 'widget_imports.dart';

class TExploreCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final String findingRelationship;

  const TExploreCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.findingRelationship,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return GestureDetector(
      onTap: () {
        // Set filter and navigate
        homeController.setLookingFor(findingRelationship);
        homeController.fetchAllUsers();
        Get.to(
          () => const HomeScreen(showBackArrow: true, centerTitle: true),
          popGesture: true, // Enable swipe back
          transition: Transition.rightToLeft,
        )?.then((_) {
          // Reset filters when returning
          homeController.resetFilters();
          homeController.fetchAllUsers();
          homeController.resetPhotoIndex();
        });
      },
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
