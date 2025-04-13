import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/cart%20screens/checkout_screen.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:provider/provider.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({super.key});

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Choose ",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "Delivery Details",
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer<LocationProvider>(
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: locationProvider.locations.length,
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
                                  color: Colors.white,
                                  border: Border.all(color: isSelected? CommonColor.primaryColor: Colors.grey[100]!),
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
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: CommonColor.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutScreen()));
                      },
                      child: Text(
                        "Confirm Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
