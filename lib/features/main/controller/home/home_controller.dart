import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/dating/dating_repository.dart';
import 'package:ve_amor_app/features/main/models/all_users_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final isLoading = false.obs;
  RxInt currentPhotoIndex = 0.obs;
  RxList<AllUsersModel> allUsers = <AllUsersModel>[].obs;
  final _auth = FirebaseAuth.instance;
  final _dating = Get.put(DatingRepository());

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  // Fetch all users from Firestore
  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      final users = await _dating.getAllUsers(_auth.currentUser!.uid);
      allUsers.assignAll(users);
      print('--------------------------${users.length}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Move to the previous photo
  void previousPhoto(int maxPhotos) {
    if (currentPhotoIndex.value > 0) {
      currentPhotoIndex.value -= 1;
    }
  }

  // Move to the next photo
  void nextPhoto(int maxPhotos) {
    if (currentPhotoIndex.value < maxPhotos - 1) {
      currentPhotoIndex.value += 1;
    }
  }

  // Reset the photo index to the first photo
  void resetPhotoIndex() {
    currentPhotoIndex.value = 0;
  }

  // Handle like action
  // Handle like action
  Future<void> likeUser(String likedUserId, String likedUserName) async {
    try {
      final currentUserId = _auth.currentUser!.uid;

      // Thực hiện hành động like qua repository
      final isMatch = await _dating.handleLike(currentUserId, likedUserId);

      allUsers.removeWhere((user) => user.id == likedUserId);

      // Kiểm tra nếu có match
      if (isMatch) {
        // TLoaders.successSnackBar(title: 'Match! You and ${likedUserName} have matched!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to like user: $e');
    }
  }

  // Handle nope action
  Future<void> nopeUser(String nopedUserId) async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      await _dating.handleNope(currentUserId, nopedUserId);
      allUsers.removeWhere((user) => user.id == nopedUserId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to nope user: $e');
    }
  }
}
