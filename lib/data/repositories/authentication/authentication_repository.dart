import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ve_amor_app/features/authentication/screens/%20initial_information/initial_information_imports.dart';
import 'package:ve_amor_app/features/authentication/screens/login/login_imports.dart';
import 'package:ve_amor_app/features/authentication/screens/onboarding/onboarding_imports.dart';
import 'package:ve_amor_app/features/authentication/screens/signup/signup_imports.dart';
import 'package:ve_amor_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ve_amor_app/utils/exceptions/firebase_exceptions.dart';
import 'package:ve_amor_app/utils/exceptions/format_exceptions.dart';
import 'package:ve_amor_app/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (!user.emailVerified) {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    }
    // Local Storage
    deviceStorage.writeIfNull('isFirstTime', true);
    // Check if it's the first time launching the app
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnBoardingScreen());
  }

// /*------------------------------- Email & Password Sign In -------------------------------*/
//   // [EmailAuthentication] - Sign In
//   Future<UserCredential> loginWithEmailPassword(String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again!';
//     }
//   }
//
  // [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // [EmailAuthentication] - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

//
//   // [EmailAuthentication] - Forget Password
//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again!';
//     }
//   }
//
//   // [ReAuthenticate] - ReAuthenticate User
//   Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
//     try {
//       // Create a credential
//       AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//
//       // ReAuthenticate
//       await _auth.currentUser!.reauthenticateWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again!';
//     }
//   }
//
// /*------------------------------- Federated identity & social sign in -------------------------------*/
//
//   // [GoogleAuthentication] - Google
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Trigger the authentication flow (kich hoat luong xac thuc)
//       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
//
//       // Create a new credential
//       final credentials = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       // Once sign in, return the UserCredential
//       return await _auth.signInWithCredential(credentials);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       if (kDebugMode) print('Some thing went wrong: $e');
//       return null;
//     }
//   }
//
//   // [FacebookAuthentication] - Facebook
//
// /*------------------------------- End identity & social sign in -------------------------------*/

  // [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      // await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
//   }
//
//   // [DeleteUser] - Remove user Auth and Firestore account
//   // Future<void> deleteAccount() async {
//   //   try {
//   //     await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//   //     await _auth.currentUser?.delete();
//   //     Get.offAll(() => const LoginScreen());
//   //   } on FirebaseAuthException catch (e) {
//   //     throw TFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw TFirebaseException(e.code).message;
//   //   } on FormatException catch (_) {
//   //     throw const TFormatException();
//   //   } on PlatformException catch (e) {
//   //     throw TPlatformException(e.code).message;
//   //   } catch (e) {
//   //     throw 'Something went wrong. Please try again!';
//   //   }
//   // }
  }
}
