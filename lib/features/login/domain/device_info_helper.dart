import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    if (await deviceInfo.deviceInfo is AndroidDeviceInfo) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (await deviceInfo.deviceInfo is IosDeviceInfo) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
    return "Unknown Device";
  }
}
