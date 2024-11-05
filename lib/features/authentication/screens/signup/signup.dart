part of 'signup_imports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Form
            const TSignupForm(),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Divider
            TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwItems),

            //Social Buttons
            const TSocialButtons(),
          ],
        ),
      ),
    );
  }
}
