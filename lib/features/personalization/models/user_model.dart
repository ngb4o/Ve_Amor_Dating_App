// Model class representing user data
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ve_amor_app/data/services/location/location_service.dart';

class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  final String username;
  final String email;
  String phoneNumber;
  List<String> profilePictures;
  String dateOfBirth;
  String gender;
  String wantSeeing;
  List<String> lifeStyle;
  String identityVerificationQR;
  String identityVerificationFaceImage;
  String findingRelationship;
  List<String> likes;
  List<String> nopes;
  List<String> matches;
  final Map<String, dynamic>? location;
  late final String zodiac;
  List<String> sports;
  List<String> pets;

  // Constructor for UserModel
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePictures,
    required this.dateOfBirth,
    required this.gender,
    required this.wantSeeing,
    required this.lifeStyle,
    required this.identityVerificationQR,
    required this.identityVerificationFaceImage,
    required this.findingRelationship,
    required this.likes,
    required this.nopes,
    required this.matches,
    this.location,
    required this.zodiac,
    required this.sports,
    required this.pets,
  });

  // Change data dateOfBirth to age
  int get age {
    if (dateOfBirth.isEmpty) return 0;
    try {
      final dob = DateFormat('dd/MM/yyyy').parse(dateOfBirth);
      final today = DateTime.now();
      int age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  // Static function to split full name into first and last name
  static List<String> nameParts(fullname) => fullname.split("");

  // Static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePictures: [],
        dateOfBirth: '',
        gender: '',
        wantSeeing: '',
        lifeStyle: [],
        identityVerificationQR: '',
        identityVerificationFaceImage: '',
        findingRelationship: '',
        likes: [],
        nopes: [],
        matches: [],
        location: null,
        zodiac: '',
        sports: [],
        pets: [],
      );

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePictures': profilePictures,
      'DateOfBirth': dateOfBirth,
      'Gender': gender,
      'WantSeeing': wantSeeing,
      'LifeStyle': lifeStyle,
      'IdentityVerificationQR': identityVerificationQR,
      'IdentityVerificationFaceImage': identityVerificationFaceImage,
      'FindingRelationship': findingRelationship,
      'Likes': likes,
      'Nopes': nopes,
      'Matches': matches,
      'Location': location,
      'Zodiac' : zodiac,
      'Sports' : sports,
      'Pets' : pets
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePictures: List<String>.from(data['ProfilePictures'] ?? []),
        dateOfBirth: data['DateOfBirth'] ?? '',
        gender: data['Gender'] ?? '',
        wantSeeing: data['WantSeeing'] ?? '',
        lifeStyle: List<String>.from(data['LifeStyle'] ?? []),
        identityVerificationQR: data['IdentityVerificationQR'] ?? '',
        identityVerificationFaceImage:
            data['IdentityVerificationFaceImage'] ?? '',
        findingRelationship: data['FindingRelationship'],
        likes: List<String>.from(data['Likes'] ?? []),
        nopes: List<String>.from(data['Nopes'] ?? []),
        matches: List<String>.from(data['Matches'] ?? []),
        location: data['Location'] as Map<String, dynamic>?,
        zodiac: data['Zodiac'] ?? '',
        sports: List<String>.from(data['Sports'] ?? []),
        pets: List<String>.from(data['Pets'] ?? [])
      );
    }
    return UserModel.empty();
  }
}
