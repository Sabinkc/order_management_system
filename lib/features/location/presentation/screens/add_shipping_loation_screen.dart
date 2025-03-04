import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:provider/provider.dart';

class AddShippingLoationScreen extends StatelessWidget {
  const AddShippingLoationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Add Shippi",
            style: TextStyle(
                fontSize: 20,
                color: CommonColor.darkGreyColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "ng Address",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Your Personal Details:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenWidth * 0.42,
                      child:
                          CommonLocationTextformField(hintText: "First Name")),
                  SizedBox(
                      width: screenWidth * 0.42,
                      child:
                          CommonLocationTextformField(hintText: "Last Name")),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              CommonLocationTextformField(hintText: "Your Phone Number"),
              SizedBox(height: screenHeight * 0.02),
              CommonLocationTextformField(hintText: "Your Email Address"),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Your Delivery Address:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenWidth * 0.42,
                      child: CommonLocationTextformField(hintText: "State")),
                  SizedBox(
                      width: screenWidth * 0.42,
                      child: CommonLocationTextformField(hintText: "City")),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenWidth * 0.42,
                      child:
                          CommonLocationTextformField(hintText: "Street/Area")),
                  SizedBox(
                      width: screenWidth * 0.42,
                      child: CommonLocationTextformField(hintText: "Landmark")),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                return Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address Category",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Row(
                              spacing: 3,
                              children: [
                                InkWell(
                                  onTap: () {
                                    locationProvider
                                        .switchAdressCategory("home");
                                  },
                                  child:
                                      locationProvider.addressCategory == "home"
                                          ? Icon(
                                              Icons.check_circle,
                                              color: CommonColor.primaryColor,
                                              size: 28,
                                            )
                                          : Icon(
                                              Icons.circle_outlined,
                                              color: CommonColor.primaryColor,
                                              size: 28,
                                            ),
                                ),
                                locationProvider.addressCategory == "home"
                                    ? Text(
                                        "Home",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CommonColor.primaryColor),
                                      )
                                    : Text(
                                        "Home",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CommonColor.darkGreyColor),
                                      )
                              ],
                            ),
                            Row(
                              spacing: 3,
                              children: [
                                InkWell(
                                  onTap: () {
                                    locationProvider
                                        .switchAdressCategory("office");
                                  },
                                  child: locationProvider.addressCategory ==
                                          "office"
                                      ? Icon(
                                          Icons.check_circle,
                                          color: CommonColor.primaryColor,
                                          size: 28,
                                        )
                                      : Icon(
                                          Icons.circle_outlined,
                                          color: CommonColor.primaryColor,
                                          size: 28,
                                        ),
                                ),
                                locationProvider.addressCategory == "office"
                                    ? Text(
                                        "Office",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CommonColor.primaryColor),
                                      )
                                    : Text(
                                        "Office",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CommonColor.darkGreyColor),
                                      ),
                              ],
                            )
                          ],
                        )
                      ],
                    ));
              }),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: CommonColor.primaryColor),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
