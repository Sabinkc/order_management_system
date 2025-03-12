import 'package:flutter/material.dart';
import 'package:order_management_system/features/location/data/location_api_service.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
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
                // final ProductApiSevice productApiSevice = ProductApiSevice();
                // final productProvider =
                //     Provider.of<ProductProvider>(context, listen: false);

                // productApiSevice.getOrderByKey("25cb1-19");
                // getCurrentLocation();
                // final LocationApiService locationApiService = LocationApiService();
                // locationApiService.deleteLocation(15);
                final locationProvider =
                    Provider.of<LocationProvider>(context, listen: false);
                locationProvider.deleteLocation(16);
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
