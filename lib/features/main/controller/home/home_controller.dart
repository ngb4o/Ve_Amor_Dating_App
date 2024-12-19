import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/data/repositories/dating/dating_repository.dart';
import 'package:ve_amor_app/features/main/models/all_users_model.dart';
import 'package:ve_amor_app/utils/popups/loaders.dart';
import 'package:ve_amor_app/common/widgets/matches_screen/match_notification_screen.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final isLoading = false.obs;
  RxInt currentPhotoIndex = 0.obs;
  RxList<AllUsersModel> allUsers = <AllUsersModel>[].obs;
  final _auth = FirebaseAuth.instance;
  final _dating = Get.put(DatingRepository());

  // Filter properties
  final RxDouble maxDistance = 50.0.obs;
  final RxString selectedZodiac = ''.obs;
  final RxList<String> selectedSports = <String>[].obs;
  final RxList<String> selectedPets = <String>[].obs;
  final RxString selectedLookingFor = ''.obs;
  final RxString genderPreference = ''.obs;
  final Rx<RangeValues> ageRange = const RangeValues(18, 100).obs;

  final Rxn<Map<String, dynamic>> currentUserLocation = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    getCurrentUserLocation();
    fetchAllUsers();
    super.onInit();
  }

  // Fetch all users from Firestore
  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      final users = await _dating.getAllUsers(_auth.currentUser!.uid);

      // Apply filters
      final filteredUsers = users.where((user) {
        // Distance filter
        if (maxDistance.value > 0) {
          double distance = user.calculateDistance(currentUserLocation.value);
          if (distance > maxDistance.value) return false;
        }

        // Age filter
        if (user.age < ageRange.value.start || user.age > ageRange.value.end) {
          return false;
        }

        // Gender filter
        if (genderPreference.value.isNotEmpty && user.gender != genderPreference.value) {
          return false;
        }

        // Zodiac filter
        if (selectedZodiac.value.isNotEmpty && user.zodiac != selectedZodiac.value) {
          return false;
        }

        // Sports filter
        if (selectedSports.isNotEmpty && !selectedSports.any((sport) => user.sports.contains(sport))) {
          return false;
        }

        // Pets filter
        if (selectedPets.isNotEmpty && !selectedPets.any((pet) => user.pets.contains(pet))) {
          return false;
        }

        // Looking for filter
        if (selectedLookingFor.value.isNotEmpty && user.findingRelationship != selectedLookingFor.value) {
          return false;
        }

        return true;
      }).toList();

      allUsers.assignAll(filteredUsers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Reset all filters
  void resetFilters() {
    maxDistance.value = 50.0;
    selectedZodiac.value = '';
    selectedSports.clear();
    selectedPets.clear();
    selectedLookingFor.value = '';
    genderPreference.value = '';
    ageRange.value = const RangeValues(18, 100);
    fetchAllUsers();
  }

  // Move to the previous photo
  void previousPhoto(int maxPhotos) {
    if (currentPhotoIndex.value > 0) {
      currentPhotoIndex.value -= 1;
    } else {
      currentPhotoIndex.value = maxPhotos - 1;
    }
  }

  // Move to the next photo
  void nextPhoto(int maxPhotos) {
    if (currentPhotoIndex.value < maxPhotos - 1) {
      currentPhotoIndex.value += 1;
    } else {
      currentPhotoIndex.value = 0;
    }
  }

  // Reset photo index
  void resetPhotoIndex() {
    if (currentPhotoIndex.value != 0) {
      currentPhotoIndex.value = 0;
    }
  }

  // Handle like action
  Future<void> likeUser(String likedUserId, String likedUserName) async {
    try {
      final currentUserId = _auth.currentUser!.uid;

      // Thực hiện hành động like qua repository
      final isMatch = await _dating.handleLike(currentUserId, likedUserId);

      allUsers.removeWhere((user) => user.id == likedUserId);

      // Kiểm tra nếu có match
      if (isMatch) {
        // Get user images
        final currentUser = await _dating.getUserById(currentUserId);
        final matchedUser = await _dating.getUserById(likedUserId);

        // Show matches Screen
        if (currentUser != null && matchedUser != null) {
          Get.dialog(
            MatchNotificationScreen(
              currentUserImage: currentUser.profilePictures.first,
              matchedUserImage: matchedUser.profilePictures.first,
              matchedUserName: matchedUser.username,
            ),
            barrierDismissible: false,
          );
        }
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

  void updateAgeRange(RangeValues values) {
    ageRange.value = values;
  }

  void toggleZodiac(String zodiac) {
    selectedZodiac.value = selectedZodiac.value == zodiac ? '' : zodiac;
  }

  void toggleSport(String sport) {
    if (selectedSports.contains(sport)) {
      selectedSports.remove(sport);
    } else {
      selectedSports.add(sport);
    }
  }

  void togglePet(String pet) {
    if (selectedPets.contains(pet)) {
      selectedPets.remove(pet);
    } else {
      selectedPets.add(pet);
    }
  }

  void setLookingFor(String lookingFor) {
    selectedLookingFor.value = lookingFor;
  }

  void setGenderPreference(String gender) {
    genderPreference.value = gender;
  }

  // Get Users Location
  Future<void> getCurrentUserLocation() async {
    try {
      final userDoc = await _dating.getUserById(_auth.currentUser!.uid);
      if (userDoc != null) {
        currentUserLocation.value = userDoc.location;
      }
    } catch (e) {
      print('Error getting current user location: $e');
    }
  }
}
