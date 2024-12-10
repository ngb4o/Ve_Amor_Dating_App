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
      final currentUserSnapshot =
          await _db.collection('Users').doc(currentUserUid).get();
      final currentUserData = currentUserSnapshot.data();

      if (currentUserData == null) {
        print('Error: Current user data not found');
        return [];
      }

      // Get current user preferences
      final String wantSeeing = currentUserData['WantSeeing'] ?? '';
      final likes = List<String>.from(currentUserData['Likes'] ?? []);
      final nopes = List<String>.from(currentUserData['Nopes'] ?? []);
      final matches = List<String>.from(currentUserData['Matches'] ?? []);

      // Users already "swiped"
      final swipedUsers = {...likes, ...nopes, ...matches};

      // Create query based on user preference
      Query<Map<String, dynamic>> usersQuery =
          _db.collection('Users').withConverter(
                fromFirestore: (snapshot, _) => snapshot.data()!,
                toFirestore: (data, _) => data,
              );

      // Filter by gender preference
      if (wantSeeing != 'Everyone') {
        usersQuery = usersQuery.where('Gender', isEqualTo: wantSeeing);
      }

      // Fetch filtered users
      final snapshot = await usersQuery.get();

      // Filter the list
      final filteredDocs = snapshot.docs.where((doc) {
        final data = doc.data();
        return doc.id != currentUserUid && // Exclude current user
            !swipedUsers.contains(doc.id) && // Exclude "swiped" users
            data['Username'] != null &&
            data['Username'].toString().isNotEmpty;
      }).toList();

      // Convert to AllUsersModel list
      return filteredDocs
          .map((doc) => AllUsersModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
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
      final likedUserLikes =
          List<String>.from(likedUserSnapshot.data()?['Likes'] ?? []);

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

  // Function to undo nope action
  Future<void> undoNope(String currentUserId, String nopedUserId) async {
    try {
      final currentUserRef = _db.collection('Users').doc(currentUserId);

      // Remove the noped user's UID from the nopes list
      await currentUserRef.update({
        "Nopes": FieldValue.arrayRemove([nopedUserId]),
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

  // Function to get last noped user
  Future<AllUsersModel?> getLastNopedUser(String currentUserId) async {
    try {
      // Get current user data to access nopes list
      final currentUserDoc =
          await _db.collection('Users').doc(currentUserId).get();
      final nopes = List<String>.from(currentUserDoc.data()?['Nopes'] ?? []);

      if (nopes.isEmpty) return null;

      // Get the last noped user's data
      final lastNopedId = nopes.last;
      final userDoc = await _db.collection('Users').doc(lastNopedId).get();

      if (!userDoc.exists) return null;

      return AllUsersModel.fromSnapshot(userDoc);
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

  // Add this method
  Future<AllUsersModel?> getUserById(String userId) async {
    try {
      final doc = await _db.collection("Users").doc(userId).get();
      if (doc.exists) {
        return AllUsersModel.fromSnapshot(doc);
      }
      return null;
    } catch (e) {
      throw 'Error getting user: $e';
    }
  }
}
