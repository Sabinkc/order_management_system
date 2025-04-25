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
//       loadAvatar();
//       final productProvider =
//           Provider.of<ProductProvider>(context, listen: false);
// //  await productProvider.getProductCategoriesWithoutAll();
//       productProvider.resetAllProducts();
//       await productProvider.getAllProduct("");

//       // await productProvider.getCategoryProducts(0);
//       if (!mounted) return;
//       final settingProvider =
//           Provider.of<SettingsProvider>(context, listen: false);
//       await settingProvider.getProfile();
//       getCurrentLocation();
//       await productProvider.getProductCategoriesWithoutAll();
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
//               loadAvatar();
//               final productProvider =
//                   Provider.of<ProductProvider>(context, listen: false);
//               await productProvider.getProductCategoriesWithoutAll();
//               // await productProvider.getAllProduct();
//               await productProvider.getCategoryProducts(0, "", reset: true);
//               if (!context.mounted) return;
//               final settingProvider =
//                   Provider.of<SettingsProvider>(context, listen: false);
//               await settingProvider.getProfile();
//               getCurrentLocation();
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
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/category_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/all_product_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/offer_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_profile_dashboard.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

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
      loadAvatar();
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      await productProvider.getProductCategoriesWithoutAll();
      productProvider.resetAllProducts();
      await productProvider.getAllProduct("");

      // await productProvider.getCategoryProducts(0);
      if (!mounted) return;
      final settingProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await settingProvider.getProfile();
      getCurrentLocation();
      // prevents from email switching data conflict
      // preventEmailSwitchingConflict();
    });

    super.initState();
  }

  Future preventEmailSwitchingConflict() async {
    if (mounted) {
      Provider.of<CartQuantityProvider>(context, listen: false)
          .cartItems
          .clear();
      Provider.of<OrderScreenProvider>(context, listen: false)
          .ordersBySandD
          .clear();
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.invoices.clear();

      simpleUiProvider.clearDateRange();
      simpleUiProvider.clearFilter();
      simpleUiProvider.clearInvoiceDateRange();
      simpleUiProvider.clearInvoiceFilter();

      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderProvider.clearFilters();
      orderProvider.clearOrders();
      await orderProvider.getOrderByStatusAndDate("", "", "");
      await productProvider.getAllInvoice(true, "", "", "");
    }
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
              loadAvatar();
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              await productProvider.getProductCategoriesWithoutAll();
              // await productProvider.getAllProduct();
              await productProvider.getCategoryProducts(0, "", reset: true);
              if (!context.mounted) return;
              final settingProvider =
                  Provider.of<SettingsProvider>(context, listen: false);
              await settingProvider.getProfile();
              getCurrentLocation();
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
