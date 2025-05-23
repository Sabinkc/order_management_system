import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/location/presentation/screens/add_shipping_loation_screen.dart';
import 'package:order_management_system/features/location/presentation/screens/edit_shipping_location_screen.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';

class ShippingLocationScreen extends StatefulWidget {
  const ShippingLocationScreen({super.key});

  @override
  State<ShippingLocationScreen> createState() => _ShippingLocationScreenState();
}

class _ShippingLocationScreenState extends State<ShippingLocationScreen> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: S.current.shippingAddress,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          
        ])),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                final locationProvider =
                    Provider.of<LocationProvider>(context, listen: false);
                locationProvider.locations.length < 3
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddShippingLoationScreen()))
                    : Utilities.showCommonSnackBar(context,
                        "Address limit exceeded. Please delete a address first to proceed!");
              },
              child: Container(
                height: screenHeight * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: CommonColor.primaryColor,
                    )),
                child: Center(
                  child: Text(
                    "+Add address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CommonColor.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
              if (locationProvider.locations.isEmpty) {
                return Center(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/address.png"),
                      Text(
                        "Address not added yet!",
                        style: TextStyle(
                          color: CommonColor.darkGreyColor,
                          // fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ));
              } else if (locationProvider.isGeAllLocationLoading == true) {
                return CircularProgressIndicator(
                  color: CommonColor.primaryColor,
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: locationProvider.locations.length,
                      itemBuilder: (context, index) {
                        // final isSelected =
                        //     index == locationProvider.selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            // locationProvider.selectAddress(index);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.grey[100]!),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                locationProvider
                                                    .locations[index].fullName,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.2,
                                              child: Text(
                                                locationProvider
                                                    .locations[index].phone,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .darkGreyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditShippingLocationScreen(
                                                          index: index,
                                                        )));
                                          },
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: CommonColor.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${locationProvider.locations[index].state} - ${locationProvider.locations[index].city}",
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.65,
                                          child: Text(
                                            "${locationProvider.locations[index].area},(${locationProvider.locations[index].landmark})",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color:
                                                    CommonColor.darkGreyColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Utilities.showCommonConfirmationBox(
                                                context,
                                                headerMessage:
                                                    "Confirm to delete?",
                                                bodyMessage:
                                                    "Are you sure you want to delte this address from your profile?",
                                                leftConfirmationMessage:
                                                    "Cancel",
                                                rightConfirmationMessage:
                                                    "Delete",
                                                onLeftButtonPressed: () {
                                              Navigator.pop(context);
                                            }, onRightButtonPressed: () async {
                                              try {
                                                final location =
                                                    locationProvider
                                                        .locations[index];
                                                await locationProvider
                                                    .deleteLocation(
                                                        location.id);

                                                // locationProvider
                                                //     .deleteAddress(index);
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      Future.delayed(
                                                          Duration(seconds: 1),
                                                          () {
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      });
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        title: Center(
                                                          child: Text(
                                                            "Address deleted successfully!",
                                                            style: TextStyle(
                                                                color: CommonColor
                                                                    .darkGreyColor,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              } catch (e) {
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                  Utilities.showCommonSnackBar(
                                                      context, "$e");
                                                }
                                              }
                                            });
                                          },
                                          child: Icon(
                                            MingCute.delete_2_fill,
                                            color: CommonColor.primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
