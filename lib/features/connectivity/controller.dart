// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
//     if (connectivityResult.contains(ConnectivityResult.none)) {
//       Get.rawSnackbar(
//         messageText: Padding(
//           padding: const EdgeInsets.only(top: 5, bottom: 8),
//           child: Center(
//             child: Text(
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 'Connect to the internet!',
//                 style: TextStyle(color: Colors.white, fontSize: 20)),
//           ),
//         ),
//         isDismissible: false,
//         duration: const Duration(seconds: 2),
//         backgroundColor: Colors.red[400]!,
//         icon: Padding(
//           padding: EdgeInsets.only(left: 40),
//           child: const Icon(
//             Icons.wifi_off,
//             color: Colors.white,
//             size: 35,
//           ),
//         ),
//         margin: EdgeInsets.zero,
//       );
//     } else {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//     }
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:order_management_system/test_screen.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (Get.isDialogOpen != true) {
        // Prevent multiple dialogs
        Get.dialog(
          PopScope(
            canPop: false, // Prevent back button dismissal
            child: AlertDialog(content: TestScreen()),
          ),
          barrierDismissible: false, // Prevent tapping outside to dismiss
        );
      }
    } else {
      if (Get.isDialogOpen == true) {
        Get.back(); // Close the dialog when the internet is restored
      }
    }
  }
}
