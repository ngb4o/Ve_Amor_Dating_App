import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/features/main/models/all_users_model.dart';

class AllUsersRepository extends GetxController {
  static AllUsersRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all users except the current user
  Future<List<AllUsersModel>> getAllUsers(String currentUserUid) async {
    try {
      // Fetch data from 'Users' collection
      final snapshot = await _db.collection('Users').get();

      // Filter out the current user from the list
      final filteredDocs = snapshot.docs
          .where((doc) => doc.id != currentUserUid)
          .toList();

      // Log the filtered data
      print('Filtered Firestore Data: ${filteredDocs.map((e) => e.data())}');

      // Convert to a list of AllUsersModel
      return filteredDocs.map((doc) => AllUsersModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
