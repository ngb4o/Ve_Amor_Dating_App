import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/features/main/models/message_model.dart';

import '../../../features/main/models/all_users_matches_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class MessageRepository extends GetxController {
  static MessageRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Fetch all matches for the current user
  Future<List<AllUsersMatchesModel>> getAllUsersMatches(String currentUserUid) async {
    try {
      // Fetch current user information
      final currentUserSnapshot = await _db.collection('Users').doc(currentUserUid).get();
      final currentUserData = currentUserSnapshot.data();

      if (currentUserData == null) {
        print('Error: Current user data not found');
        return [];
      }

      // Get Matches list of the current user
      final matches = List<String>.from(currentUserData['Matches'] ?? []);

      if (matches.isEmpty) {
        return [];
      }

      // Fetch matched users from Firestore
      final snapshot =
      await _db.collection('Users').where(FieldPath.documentId, whereIn: matches).get();

      // Convert to a list of `AllUsersModel`
      return snapshot.docs.map((doc) => AllUsersMatchesModel.fromSnapshot(doc)).toList();
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

  // Send Message
  Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _db.collection("Chat_rooms").doc(chatRoomId).collection("Message").add(newMessage.toMap());
  }

  // Get Message From Firebase
  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _db
        .collection("Chat_rooms")
        .doc(chatRoomID)
        .collection("Message")
        .orderBy("Timestamp", descending: false)
        .snapshots();
  }

  // Get All Users Stream Except Blocked Users
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;

    return _db
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final usersSnapshot = await _db.collection('Users').get();

      return usersSnapshot.docs
          .where((doc) => doc.data()['Email'] != currentUser.email && !blockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  // Report User
  Future<void> reportUser(String messageID, String userID) async {
    final currentUser = _auth.currentUser;
    final report = {
      'ReportedBy': currentUser!.uid,
      'MessageID': messageID,
      'MessageOwnerID': userID,
      'Timestamp': FieldValue.serverTimestamp(),
    };

    await _db.collection('Reports').add(report);
  }

  // Block User
  Future<void> blockUser(String userID) async {
    final currentUser = _auth.currentUser;
    await _db.collection('Users').doc(currentUser!.uid).collection('BlockedUsers').doc(userID).set({});
  }

  // Unblock User
  Future<void> unblockUser(String blockedUserID) async {
    final currentUser = _auth.currentUser;
    await _db
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserID)
        .delete();
  }

  // Get Block Users
  Stream<List<Map<String, dynamic>>> getBlockUsersStream(String userID) {
    return _db.collection('Users').doc(userID).collection('BlockedUsers').snapshots().asyncMap(
      (snapshot) async {
        final blockUserIds = snapshot.docs.map((doc) => doc.id).toList();

        final userDocs = await Future.wait(blockUserIds.map((id) => _db.collection('Users').doc(id).get()));

        return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      },
    );
  }
}
