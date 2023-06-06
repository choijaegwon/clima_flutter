import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  double? latitude;
  double? longitude;

  /// 권한요청
  Future<void> getCurrentLocation() async {
    print('getCurrentLocation');
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await _getLocation();
      print('현재 위치: $latitude, $longitude');
    } else {
      print('위치 액세스 권한이 거부되었습니다.');
    }
  }

  /// 위치정보 받아오기
  Future<void> _getLocation() async {
    print('_getLocation');
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('위치 정보를 가져오는 중 오류가 발생했습니다: $e');
    }
  }
}
