import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ve_amor_app/generated/assets.dart';
import 'package:ve_amor_app/utils/helpers/network_manager.dart';
import 'package:ve_amor_app/utils/popups/full_screen_loader.dart';

class LocationService {
  // Kiểm tra và yêu cầu quyền truy cập vị trí
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // Lấy vị trí hiện tại
  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;

    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Getting your current location...', Assets.animations141594AnimationOfDocer);

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  // Chuyển đổi tọa độ thành địa chỉ
  Future<String?> getAddressFromCoordinates(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];

        final addressParts = [
          // place.street,
          // place.subLocality,
          // place.locality,
          place.administrativeArea,
          // place.country
        ].where((part) => part != null && part.isNotEmpty).toList();

        return addressParts.join(', ');
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  // Lấy thông tin vị trí đầy đủ
  Future<LocationInfo?> getCurrentLocationInfo() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    final address = await getAddressFromCoordinates(position);

    return LocationInfo(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }
}

class LocationInfo {
  final double latitude;
  final double longitude;
  final String? address;

  LocationInfo({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}
