import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/dating/dating_repository.dart';
import 'package:ve_amor_app/features/main/models/all_users_model.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final isLoading = false.obs;
  RxInt currentPhotoIndex = 0.obs;
  RxList<AllUsersModel> allUsers = <AllUsersModel>[].obs;
  final _auth = FirebaseAuth.instance;
  final _dating = Get.put(DatingRepository());

  // Filter properties
  final RxDouble maxDistance = 51.0.obs;
  final RxBool showDistantProfiles = true.obs;
  final RxString genderPreference = 'Nữ'.obs;
  final Rx<RangeValues> ageRange = const RangeValues(18, 31).obs;

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  // Fetch all users from Firestore
  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      final users = await _dating.getAllUsers(
        _auth.currentUser!.uid,
        // maxDistance: maxDistance.value,
        // showDistantProfiles: showDistantProfiles.value,
        // genderPreference: genderPreference.value,
        // minAge: ageRange.value.start.toInt(),
        // maxAge: ageRange.value.end.toInt(),
      );
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
    } else {
      currentPhotoIndex.value = maxPhotos - 1; // Go to last photo when at start
    }
  }

  // Move to the next photo
  void nextPhoto(int maxPhotos) {
    if (currentPhotoIndex.value < maxPhotos - 1) {
      currentPhotoIndex.value += 1;
    } else {
      currentPhotoIndex.value = 0; // Auto reset when reaching end
    }
  }

  // Reset photo index
  void resetPhotoIndex() {
    if (currentPhotoIndex.value != 0) {
      currentPhotoIndex.value = 0;
    }
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

  // Undo last nope action
  Future<void> undoLastNope() async {
    try {
      final currentUserId = _auth.currentUser!.uid;

      // Get the last noped user
      final lastNopedUser = await _dating.getLastNopedUser(currentUserId);

      if (lastNopedUser != null) {
        // Remove from nopes list in Firebase
        await _dating.undoNope(currentUserId, lastNopedUser.id);

        // Add user back to allUsers list at the beginning
        allUsers.insert(0, lastNopedUser);

        // Reset photo index
        resetPhotoIndex();

        TLoaders.successSnackBar(
          title: 'Undo Successful',
          message: 'Previous profile has been restored',
        );
      } else {
        TLoaders.warningSnackBar(
          title: 'No Profiles to Undo',
          message: 'You haven\'t noped any profiles recently',
        );
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Error',
        message: 'Failed to undo last action: $e',
      );
    }
  }

  // Filter methods
  void updateMaxDistance(double value) {
    maxDistance.value = value;
  }

  void toggleShowDistantProfiles() {
    showDistantProfiles.value = !showDistantProfiles.value;
  }

  void setGenderPreference(String gender) {
    genderPreference.value = gender;
  }

  void updateAgeRange(RangeValues values) {
    ageRange.value = values;
  }
}
