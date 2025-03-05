import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/location/presentation/screens/add_shipping_loation_screen.dart';
import 'package:order_management_system/features/location/presentation/screens/edit_shipping_location_screen.dart';
import 'package:provider/provider.dart';

class ShippingLocationScreen extends StatelessWidget {
  const ShippingLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Select Shipping ",
            style: TextStyle(
                fontSize: 20,
                color: CommonColor.darkGreyColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "Address",
            style: TextStyle(
                fontSize: 20,
                color: CommonColor.darkGreyColor,
                fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: CommonColor.primaryColor,
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
            GestureDetector(
              onTap: () {
                final locationProvider =
                    Provider.of<LocationProvider>(context, listen: false);
                locationProvider.addresses.length < 3
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddShippingLoationScreen()))
                    : Utilities.showCommonSnackBar(context,
                        "Address limit exceeded. Please delete a address first to proceed!");
              },
              child: Container(
                height: screenHeight * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
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
              if (locationProvider.addresses.isEmpty) {
                return Center(
                    child: Text(
                  "No addresses added!",
                  style: TextStyle(
                    color: CommonColor.mediumGreyColor,
                    fontSize: 20,
                  ),
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: locationProvider.addresses.length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            index == locationProvider.selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            locationProvider.selectAddress(index);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: isSelected
                                      ? Border.all(
                                          color: CommonColor.primaryColor)
                                      : Border.all(color: Colors.grey[100]!),
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
                                            Text(
                                              locationProvider
                                                  .addresses[index].firstName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              locationProvider
                                                  .addresses[index].lastName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              locationProvider
                                                  .addresses[index].phone,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      CommonColor.darkGreyColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditShippingLocationScreen(index: index,)));
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
                                      "${locationProvider.addresses[index].state} - ${locationProvider.addresses[index].city}",
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${locationProvider.addresses[index].street},${locationProvider.addresses[index].city} (${locationProvider.addresses[index].landmark})",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: CommonColor.darkGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: CommonColor
                                                      .primaryColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            child: Text(
                                              locationProvider
                                                  .addresses[index].category,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                            }, onRightButtonPressed: () {
                                              locationProvider
                                                  .deleteAddress(index);
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 1),
                                                        () {
                                                      if (context.mounted) {
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
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
