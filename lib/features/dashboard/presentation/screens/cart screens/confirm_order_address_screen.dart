import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/cart%20screens/add_address_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/cart%20screens/choose_address_screen.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:provider/provider.dart';

class ConfirmOrderAddressScreen extends StatefulWidget {
  const ConfirmOrderAddressScreen({super.key});

  @override
  State<ConfirmOrderAddressScreen> createState() =>
      _ConfirmOrderAddressScreenState();
}

class _ConfirmOrderAddressScreenState extends State<ConfirmOrderAddressScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      locationProvider.getAllLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
     
      body: Consumer<LocationProvider>(
          builder: (context, locationProvider, child) {
        if (locationProvider.isGeAllLocationLoading == true) {
          return Center(
              child: CircularProgressIndicator(
            color: CommonColor.primaryColor,
          ));
        } else {
          return locationProvider.locations.isEmpty
              ? AddAddressScreen()
              : ChooseAddressScreen();
        }
      }),
    );
  }
}
