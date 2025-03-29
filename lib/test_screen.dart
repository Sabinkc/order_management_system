import 'package:flutter/material.dart';
import 'package:order_management_system/features/location/data/location_api_service.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/settings/data/profile_api_service.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:developer' as logger;
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
// import 'dart:developer' as logger;

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                // final locationProvider =
                //     Provider.of<LocationProvider>(context, listen: false);
                // locationProvider.updateLocation(
                //     28,
                //     "dd",
                //     "9812",
                //     "sabinkc1206@gmail.com",
                //     12,
                //     13,
                //     "prefecture 1",
                //     "city",
                //     "area",
                //     "gg");
                final settingProvider =
                    Provider.of<SettingsProvider>(context, listen: false);
                settingProvider.updatProfile("sabin", "sabinkc1206@gmail.com",
                    "9812060688", "male", "Ilam");
              },
              child: Text("Press")),
          Center(child: Text("Test Screen")),
        ],
      ),
    );
  }
}

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}

// import 'package:flutter/material.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Text("Invoice Screen")),
//     );
//   }
// }
