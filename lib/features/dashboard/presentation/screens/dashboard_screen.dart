import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/new_arrival_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/popular_product_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/top_container_dashboard.dart';
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
        backgroundColor: Colors.white,
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
                TopContainerDashboard(),
                NewArrivalWidget(),
                PopularProductWidget(),
                // SizedBox(
                //   height: screenHeight * 0.67,
                // ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SearchWidgetDashboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
