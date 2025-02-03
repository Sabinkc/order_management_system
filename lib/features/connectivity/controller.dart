// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:order_management_system/test_screen.dart';

// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
//     if (connectivityResult.contains(ConnectivityResult.none)) {
//       if (Get.isDialogOpen != true) {
//         // Prevent multiple dialogs
//         Get.dialog(
//           PopScope(
//             canPop: true, // Prevent back button dismissal
//             child: AlertDialog(content: TestScreen()),
//           ),
//           barrierDismissible: false, // Prevent tapping outside to dismiss
//         );
//       }
//     } else {
//       if (Get.isDialogOpen == true) {
//         Get.back(); // Close the dialog when the internet is restored
//       }
//     }
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:order_management_system/features/connectivity/offline_alert_box.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool wasPreviouslyOffline = false; // Flag to track previous connection state

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection(); // Check connection status when app starts
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();
    wasPreviouslyOffline = connectivityResult.contains(ConnectivityResult.none);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (Get.isDialogOpen != true) {
        // Show alert dialog when internet is lost
        Get.dialog(
          PopScope(
            canPop: false, // Prevent back button dismissal
            child: AlertDialog(content: OfflineAlertBox()),
          ),
          barrierDismissible: false, // Prevent tapping outside to dismiss
        );
      }
      wasPreviouslyOffline = true; // Mark as offline
    } else {
      // Close the no-internet dialog if open
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      // Show snackbar ONLY IF the internet was lost before
      if (wasPreviouslyOffline) {
        _showInternetConnectedSnackbar();
      }

      wasPreviouslyOffline = false; // Reset flag after restoring connection
    }
  }

  void _showInternetConnectedSnackbar() {
    Get.snackbar(
      "Connected",
      "Internet connection restored successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(10),
      borderRadius: 8,
    );
  }
}
