import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/checkout_widget.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/invoice_widget_dashboard.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/orders_widget_dashboard.dart';
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
    permission = await Geolocator.requestPermission(); // Request permission here

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
  
if(mounted){
    final locationProvider = Provider.of<LocationProvider>(context,listen: false);
  locationProvider.addLatitudeLongitue("${position.longitude}","${position.latitude}");
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
                SizedBox(
                  height: screenWidth * 0.05,
                ),
                Consumer<CartQuantityProvider>(
                    builder: (context, provider, child) {
                  return provider.cartItems.isEmpty
                      ? SizedBox(
                          height: screenHeight * 0.65,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, bottom: 0, top: 20),
                            child: Center(
                              child: SizedBox(
                                  height: screenHeight * 0.5,
                                  // color: Colors.red,
                                  child: Column(spacing: 15, children: [
                                    Image.asset(
                                      "assets/images/empty_cart.png",
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      "No products in the cart!",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: CommonColor.darkGreyColor),
                                    ),
                                  ])),
                            ),
                          ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Orders",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            SizedBox(
                              height: screenWidth * 0.002,
                            ),
                            Divider(),
                            OrdersWidgetDashboard(),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Invoice Details:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            InvoiceWidgetDashboard(),
                            SizedBox(
                              height: screenHeight * 0.005,
                            ),
                            Divider(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            CheckoutWidget(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Divider(),
                          ],
                        );
                }),
                SizedBox(
                  height: screenHeight * 0.001,
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
