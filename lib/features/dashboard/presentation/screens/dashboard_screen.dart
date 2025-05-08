// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
// import 'package:order_management_system/features/dashboard/presentation/widgets/category_row_dashboard.dart';
// import 'package:order_management_system/features/dashboard/presentation/widgets/all_product_widget.dart';
// import 'package:order_management_system/features/dashboard/presentation/widgets/offer_widget.dart';
// import 'package:order_management_system/features/dashboard/presentation/widgets/search_row_dashboard.dart';
// import 'package:order_management_system/features/dashboard/presentation/widgets/top_profile_dashboard.dart';
// import 'package:order_management_system/features/location/domain/location_provider.dart';
// import 'package:order_management_system/features/settings/domain/settings_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:developer' as logger;

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   Future<void> getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // logger.log("Location service disabled");
//       return; // Stop execution if service is disabled
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // logger.log("Location permission denied. Requesting permission...");
//       permission =
//           await Geolocator.requestPermission(); // Request permission here

//       if (permission == LocationPermission.denied) {
//         // logger.log("Location permission denied again.");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // logger.log("Location permission denied forever. Cannot request again.");
//       return;
//     }

//     // Get current position
//     Position position = await Geolocator.getCurrentPosition();

//     if (mounted) {
//       final locationProvider =
//           Provider.of<LocationProvider>(context, listen: false);
//       locationProvider.addLatitudeLongitue(
//           "${position.longitude}", "${position.latitude}");
//     }
//     logger.log("get current location api called");
//     // logger.log("Longitude: ${position.longitude}");
//     // logger.log("Latitude: ${position.latitude}");
//   }

//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       if (!mounted) return;
//       final productProvider =
//           Provider.of<ProductProvider>(context, listen: false);
//       productProvider.resetOfferProducts();
//       // productProvider.resetAllProducts();
//       // await productProvider.getAllProduct("");
//       productProvider.resetWidgetProducts();
//       final settingProvider =
//           Provider.of<SettingsProvider>(context, listen: false);
//       getCurrentLocation();
//       await Future.wait([
//         loadAvatar(),
//         productProvider.getOfferProduct(""),
//         productProvider.getProductCategoriesWithoutAll(),
//         settingProvider.getProfile(),
//         productProvider.getWidgetProduct(""),
//       ]);
//     });

//     super.initState();
//   }

//   Future loadAvatar() async {
//     try {
//       final profileProvider =
//           Provider.of<SettingsProvider>(context, listen: false);

//       await profileProvider.loadProfileAvatar();
//     } catch (e) {
//       if (!mounted) return;
//       logger.log("$e");
//       // Utilities.showCommonSnackBar(context, "$e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return KeyboardDismisser(
//       child: Scaffold(
//         backgroundColor: CommonColor.scaffoldbackgroundColor,
//         // appBar: PreferredSize(
//         //     preferredSize: Size.fromHeight(kToolbarHeight),
//         //     child: AppbarDashboard()),

//         body: SafeArea(
//           child: RefreshIndicator(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             edgeOffset: 2,
//             color: CommonColor.primaryColor,
//             onRefresh: () async {
//               final productProvider =
//                   Provider.of<ProductProvider>(context, listen: false);
//               productProvider.resetOfferProducts();
//               // productProvider.resetAllProducts();
//               // await productProvider.getAllProduct("");
//               productProvider.resetWidgetProducts();

//               if (!context.mounted) return;
//               final settingProvider =
//                   Provider.of<SettingsProvider>(context, listen: false);

//               Future.wait([
//                 settingProvider.getProfile(),
//                 loadAvatar(),
//                 productProvider.getProductCategoriesWithoutAll(),
//                 productProvider.getOfferProduct(""),
//                 productProvider.getWidgetProduct(""),
//                 productProvider.getCategoryProducts(0, "", reset: true),
//                 getCurrentLocation(),
//               ]);
//             },
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.02,
//                   ),
//                   TopProfileDashboard(),
//                   SizedBox(
//                     height: screenWidth * 0.04,
//                   ),
//                   SearchRowDashboard(),
//                   SizedBox(
//                     height: screenWidth * 0.03,
//                   ),
//                   CategoryRowDashboard(),
//                   OfferWidget(),
//                   AllProductWidget(),
//                   SizedBox(
//                     height: screenHeight * 0.01,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/category_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/all_product_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/offer_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_profile_dashboard.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // logger.log("Location service disabled");
      return; // Stop execution if service is disabled
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // logger.log("Location permission denied. Requesting permission...");
      permission =
          await Geolocator.requestPermission(); // Request permission here

      if (permission == LocationPermission.denied) {
        // logger.log("Location permission denied again.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // logger.log("Location permission denied forever. Cannot request again.");
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition();

    if (mounted) {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      locationProvider.addLatitudeLongitue(
          "${position.longitude}", "${position.latitude}");
    }
    logger.log("get current location api called");
    // logger.log("Longitude: ${position.longitude}");
    // logger.log("Latitude: ${position.latitude}");
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.resetOfferProducts();
      // productProvider.resetAllProducts();
      // await productProvider.getAllProduct("");
      productProvider.resetWidgetProducts();
      productProvider.resetProductCategoriesWithOutAll();
      final settingProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      getCurrentLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String selectedLan = prefs.getString('language') ?? 'en';
      if (selectedLan == "en") {
        await Future.wait([
          loadAvatar(),
          settingProvider.getProfile(),
          productProvider.getOfferProduct(""),
          productProvider.getProductCategoriesWithoutAll(),
          productProvider.getWidgetProduct(""),
        ]);
      } else {
        await Future.wait([
          loadAvatar(),
          settingProvider.getProfile(),
          productProvider.getOfferProductinJapanese(""),
          productProvider.getProductCategoriesWithoutAllinJapanese(),
          productProvider.getWidgetProductinJapanese(""),
        ]);
      }
    });

    super.initState();
  }

  Future loadAvatar() async {
    try {
      final profileProvider =
          Provider.of<SettingsProvider>(context, listen: false);

      await profileProvider.loadProfileAvatar();
    } catch (e) {
      if (!mounted) return;
      logger.log("$e");
      // Utilities.showCommonSnackBar(context, "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(kToolbarHeight),
        //     child: AppbarDashboard()),

        body: SafeArea(
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            elevation: 0,
            edgeOffset: 2,
            color: CommonColor.primaryColor,
            onRefresh: () async {
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              productProvider.resetOfferProducts();
              // productProvider.resetAllProducts();
              // await productProvider.getAllProduct("");
              productProvider.resetWidgetProducts();
              productProvider.resetProductCategoriesWithOutAll();

              if (!context.mounted) return;
              final settingProvider =
                  Provider.of<SettingsProvider>(context, listen: false);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String selectedLan = prefs.getString('language') ?? 'en';

              if (selectedLan == "en") {
                Future.wait([
                  settingProvider.getProfile(),
                  loadAvatar(),
                  productProvider.getProductCategoriesWithoutAll(),
                  productProvider.getOfferProduct(""),
                  productProvider.getWidgetProduct(""),
                  // productProvider.getCategoryProducts(0, "", reset: true),
                  getCurrentLocation(),
                ]);
              } else {
                Future.wait([
                  settingProvider.getProfile(),
                  loadAvatar(),
                  getCurrentLocation(),
                  productProvider.getProductCategoriesWithoutAllinJapanese(),
                  productProvider.getOfferProductinJapanese(""),
                  productProvider.getWidgetProductinJapanese(""),
                  // productProvider.getCategoryProducts(0, "", reset: true),
                ]);
              }
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TopProfileDashboard(),
                  SizedBox(
                    height: screenWidth * 0.04,
                  ),
                  SearchRowDashboard(),
                  SizedBox(
                    height: screenWidth * 0.03,
                  ),
                  CategoryRowDashboard(),
                  OfferWidget(),
                  AllProductWidget(),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
