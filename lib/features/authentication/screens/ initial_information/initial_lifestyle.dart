// part of 'initial_information_imports.dart';
//
// class InitialLifestylePage extends StatelessWidget {
//   const InitialLifestylePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppbar(
//         showBackArrow: true,
//         actions: [
//           // Skip button
//           TextButton(
//             onPressed: () {},
//             child:
//                 Text('Skip', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.primary)),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             Text(
//               TTexts.titleLifestyle,
//               style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: TSizes.sm),
//
//             // SubTitle
//             Text(TTexts.subTitleLifestyle, style: Theme.of(context).textTheme.bodySmall),
//             const SizedBox(height: TSizes.sm),
//             const Divider(),
//
//             const QuestionSection(
//               question: 'How often do you drink alcohol?',
//               options: [
//                 'Not for me',
//                 'Always sober',
//                 'Drink responsibly',
//                 'Only on special occasions',
//                 'Socially on weekends',
//                 'Almost every night',
//               ],
//             ),
//             const Divider(),
//             const QuestionSection(
//               question: 'Do you smoke?',
//               options: [
//                 'Smoke with friends',
//                 'Smoke when drinking',
//                 'Don’t smoke',
//                 'Smoke frequently',
//                 'Trying to quit',
//               ],
//             ),
//             const Divider(),
//
//             const QuestionSection(
//               question: 'Do you exercise?',
//               options: [
//                 'Daily',
//                 'Frequently',
//                 'Occasionally',
//                 'Don’t exercise',
//               ],
//             ),
//             const Divider(),
//
//             const QuestionSection(
//               question: 'Do you have pets?',
//               options: [
//                 'Dog',
//                 'Cat',
//                 'Fish',
//                 'Others',
//                 'No pets',
//               ],
//             ),
//             const SizedBox(height: 24),
//             // Button Next
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
//                 onPressed: () => Get.to(() => const InitialIdentityVerification()),
//                 child: const Text(TTexts.next, style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
