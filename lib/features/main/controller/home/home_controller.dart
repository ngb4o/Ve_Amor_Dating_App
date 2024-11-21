import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/all_users/all_users_repository.dart';
import 'package:ve_amor_app/features/main/models/all_users_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final isLoading = false.obs;
  RxInt currentPhotoIndex = 0.obs;
  final _allUsersRepository = Get.put(AllUsersRepository());
  RxList<AllUsersModel> allUsers = <AllUsersModel>[].obs;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  // Fetch all users from Firestore
  Future<void> fetchAllUsers() async {
    try {
      isLoading.value = true;

      final users = await _allUsersRepository.getAllUsers(_auth.currentUser!.uid);
      allUsers.assignAll(users);
      print('--------------------------$users.length');
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
}
