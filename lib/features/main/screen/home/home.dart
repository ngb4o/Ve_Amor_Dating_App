part of 'home_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Appbar
          THomeAppBar(),

          // Swipe Card
          THomeSwipeCard()
        ],
      ),
    );
  }
}
