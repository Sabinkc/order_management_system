import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoHelper {
  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    // Check platform
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return "Android Device: ${androidInfo.model}";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return "iOS Device: ${iosInfo.utsname.machine}";
    }
    return "Unknown Device";
  }
}
