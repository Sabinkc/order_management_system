import 'package:get/get.dart';
import 'package:order_management_system/features/connectivity/controller.dart';


class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}