part of 'login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: TSizes.appBarHeight,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
        ),
        child: Column(
          children: [
            // Logo, Title & Sub-Title
            const TLoginHeader(),

            // Form
            const TLoginForm(),

            // Divider
            TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Footer
            const TSocialButtons()
          ],
        ),
      ),
    );
  }
}
