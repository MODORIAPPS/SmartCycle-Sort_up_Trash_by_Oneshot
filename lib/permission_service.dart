import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();


  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  /// 연락처 권한 요청
  Future<bool> requestContactsPermission() async {
    return _requestPermission(PermissionGroup.contacts);
  }

  /// 위치 권한 사용 요청
  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationAlways);
  }

  /// (권한, 거절시 실행할 메소드)
  Future<bool> requestPermission({PermissionGroup permission, Function onPermissionDenied, Future onPermissionGranted}) async {
    var granted = await _requestPermission(permission);
    if (!granted) {
      onPermissionDenied();
    } else if (granted) {
      onPermissionGranted;
    }
    return granted;
  }

  /// 권한 확인
  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
    await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

}
