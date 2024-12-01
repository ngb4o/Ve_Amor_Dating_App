import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/authentication/authentication_repository.dart';
import 'package:ve_amor_app/features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Fetch user details by user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).get();

      if (documentSnapshot.exists) {
        // Return user data if exists
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        // Return empty if user not found
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Update user details in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection('Users').doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Update specific fields in Firestore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Delete user record from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Upload multiple images to Firebase Storage
  Future<List<String>> uploadImages(List<String> filePaths) async {
    List<String> uploadedUrls = [];
    for (String path in filePaths) {
      try {
        String fileName = path.split('/').last;
        Reference ref = _storage.ref().child('profile_photos/$fileName');
        UploadTask uploadTask = ref.putFile(File(path));

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        uploadedUrls.add(downloadUrl); // Collect uploaded URLs
      } on FirebaseException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on TPlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again!';
      }
    }
    return uploadedUrls;
  }

  // Upload a single profile image to Firebase
  Future<String> uploadProfileImage(String filePath) async {
    try {
      String fileName = filePath.split('/').last;
      Reference ref = _storage.ref('profile_photos/$fileName');
      TaskSnapshot snapshot = await ref.putFile(File(filePath));
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update user data with the new image
      final user = await fetchUserDetails();
      user.profilePictures.add(downloadUrl);
      await updateUserDetails(user);

      return downloadUrl; // Return download URL
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Upload face image to Firebase
  Future<String> uploadFaceImage(String filePath) async {
    try {
      String fileName = filePath.split('/').last;
      Reference ref = _storage.ref('profile_photos/$fileName');
      TaskSnapshot snapshot = await ref.putFile(File(filePath));
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update user data with the new image
      final user = await fetchUserDetails();
      user.identityVerificationFaceImage = downloadUrl;

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  // Delete an image from Firebase Storage and Firestore
  Future<void> deleteProfileImage(String imageUrl) async {
    try {
      // Delete from storage
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();

      // Remove the image from user data
      final user = await fetchUserDetails();
      user.profilePictures.remove(imageUrl);
      await updateUserDetails(user);
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  /// Check if identity number already exists
  Future<bool> isIdentityNumberExists(String identityNumber) async {
    try {
      final querySnapshot =
          await _db.collection("Users").where("IdentityVerificationQR", isEqualTo: identityNumber).get();

      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }
}
