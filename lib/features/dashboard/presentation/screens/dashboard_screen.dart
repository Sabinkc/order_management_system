import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/category_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/all_product_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_row_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_container_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_profile_dashboard.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
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
      logger.log("Location service disabled");
      return; // Stop execution if service is disabled
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      logger.log("Location permission denied. Requesting permission...");
      permission =
          await Geolocator.requestPermission(); // Request permission here

      if (permission == LocationPermission.denied) {
        logger.log("Location permission denied again.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      logger.log("Location permission denied forever. Cannot request again.");
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
    logger.log("Longitude: ${position.longitude}");
    logger.log("Latitude: ${position.latitude}");
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(kToolbarHeight),
        //     child: AppbarDashboard()),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenWidth * 0.05,
                ),
                // TopContainerDashboard(),
                TopProfileDashboard(),
                SizedBox(
                  height: screenWidth * 0.05,
                ),
                SearchRowDashboard(),
                CategoryRowDashboard(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      spacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Offers",
                              style: TextStyle(
                                color: CommonColor.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: CommonColor.primaryColor),
                            )
                          ],
                        ),
                        Container(
                          height: 180,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "50% off on all every electronic products!",
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CommonColor.primaryColor,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Shop Now",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 150,
                                child: Image.asset(
                                  "assets/images/laptopcharger.jpeg",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                AllProductWidget(),
                // SizedBox(
                //   height: screenHeight * 0.67,
                // ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
