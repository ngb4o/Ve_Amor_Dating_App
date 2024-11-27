import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatingRepository extends GetxController{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Hàm xử lý "Like"
  Future<void> handleLike(String currentUserId, String likedUserId) async {
    try {
      // Thêm UID của user được like vào danh sách `likes` của user hiện tại
      final currentUserRef = _db.collection('Users').doc(currentUserId);
      final likedUserRef = _db.collection('Users').doc(likedUserId);

      // Cập nhật danh sách likes
      await currentUserRef.update({
        "Likes": FieldValue.arrayUnion([likedUserId]),
      });

      // Kiểm tra xem người được like có thích lại không
      final likedUserSnapshot = await likedUserRef.get();
      final likedUserLikes = List<String>.from(likedUserSnapshot.data()?['Likes'] ?? []);

      if (likedUserLikes.contains(currentUserId)) {
        // Nếu cả hai thích nhau, thêm vào danh sách matches
        await currentUserRef.update({
          "Matches": FieldValue.arrayUnion([likedUserId]),
        });
        await likedUserRef.update({
          "Matches": FieldValue.arrayUnion([currentUserId]),
        });
      }
    } catch (e) {
      print("Error handling like: $e");
      throw Exception("Failed to process like.");
    }
  }

  // Hàm xử lý "Nope"
  Future<void> handleNope(String currentUserId, String nopedUserId) async {
    try {
      // Thêm UID của user bị nope vào danh sách `nopes` của user hiện tại
      final currentUserRef = _db.collection('Users').doc(currentUserId);

      await currentUserRef.update({
        "Nopes": FieldValue.arrayUnion([nopedUserId]),
      });
    } catch (e) {
      print("Error handling nope: $e");
      throw Exception("Failed to process nope.");
    }
  }
}
