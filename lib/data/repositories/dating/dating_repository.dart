import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/main/models/all_users_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class DatingRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all users except the current user
  Future<List<AllUsersModel>> getAllUsers(String currentUserUid) async {
    try {
      // Fetch current user information
      final currentUserSnapshot = await _db.collection('Users').doc(currentUserUid).get();
      final currentUserData = currentUserSnapshot.data();

      if (currentUserData == null) {
        print('Error: Current user data not found');
        return [];
      }

      // Get Likes, Nopes, Matches list of the current user
      final likes = List<String>.from(currentUserData['Likes'] ?? []);
      final nopes = List<String>.from(currentUserData['Nopes'] ?? []);
      final matches = List<String>.from(currentUserData['Matches'] ?? []);

      // Users already "swiped"
      final swipedUsers = {...likes, ...nopes, ...matches};

      // Fetch all users from Firestore
      final snapshot = await _db.collection('Users').get();

      // Filter the list, excluding the current user and already "swiped" users
      final filteredDocs = snapshot.docs.where((doc) {
        final data = doc.data();
        return doc.id != currentUserUid &&
            !swipedUsers.contains(doc.id) && // Exclude "swiped" users
            data['Username'] != null &&
            data['Username'].toString().isNotEmpty;
      }).toList();

      // Convert to a list of `AllUsersModel`
      return filteredDocs.map((doc) => AllUsersModel.fromSnapshot(doc)).toList();
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

  // Function to handle "Like"
  // Function to handle "Like"
  Future<bool> handleLike(String currentUserId, String likedUserId) async {
    try {
      final currentUserRef = _db.collection('Users').doc(currentUserId);
      final likedUserRef = _db.collection('Users').doc(likedUserId);

      // Update the likes list
      await currentUserRef.update({
        "Likes": FieldValue.arrayUnion([likedUserId]),
      });

      // Check if the liked user also liked back
      final likedUserSnapshot = await likedUserRef.get();
      final likedUserLikes = List<String>.from(likedUserSnapshot.data()?['Likes'] ?? []);

      if (likedUserLikes.contains(currentUserId)) {
        // Add to matches list if mutual like
        await currentUserRef.update({
          "Matches": FieldValue.arrayUnion([likedUserId]),
        });
        await likedUserRef.update({
          "Matches": FieldValue.arrayUnion([currentUserId]),
        });
        return true; // Match found
      }
      return false; // No match
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

  // Function to handle "Nope"
  Future<void> handleNope(String currentUserId, String nopedUserId) async {
    try {
      // Add the noped user's UID to the `nopes` list of the current user
      final currentUserRef = _db.collection('Users').doc(currentUserId);

      await currentUserRef.update({
        "Nopes": FieldValue.arrayUnion([nopedUserId]),
      });
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
