import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:provider/provider.dart';

class AddShippingLoationScreen extends StatelessWidget {
  AddShippingLoationScreen({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController prefectureController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return KeyboardDismisser(
      child: Scaffold(
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
                    "Your Contact Details:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                    child: CommonLocationTextformField(
                        controller: fullNameController, hintText: "Full Name")),
                SizedBox(height: screenHeight * 0.02),
                CommonLocationTextformField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    hintText: "Your Phone Number"),
                SizedBox(height: screenHeight * 0.02),
                CommonLocationTextformField(
                    controller: emailController,
                    hintText: "Your Email Address"),
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
                        child: CommonLocationTextformField(
                            controller: prefectureController,
                            hintText: "Prefecture")),
                    SizedBox(
                        width: screenWidth * 0.42,
                        child: CommonLocationTextformField(
                            controller: cityController, hintText: "City")),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: screenWidth * 0.42,
                        child: CommonLocationTextformField(
                            controller: areaController,
                            hintText: "Street/Area")),
                    SizedBox(
                        width: screenWidth * 0.42,
                        child: CommonLocationTextformField(
                            controller: landmarkController,
                            hintText: "Landmark")),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (fullNameController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty ||
                            areaController.text.trim().isEmpty ||
                            cityController.text.trim().isEmpty ||
                            prefectureController.text.trim().isEmpty) {
                          Utilities.showCommonSnackBar(
                              context, "All fields are required!",
                              color: Colors.red, durationMilliseconds: 500);
                        } else {
                          try {
                            final locationProvider =
                                Provider.of<LocationProvider>(context,
                                    listen: false);
                            await locationProvider.createShippingLocation(
                                fullNameController.text.trim(),
                                phoneController.text.trim(),
                                emailController.text.trim(),
                                12.00,
                                13.00,
                                prefectureController.text.trim(),
                                cityController.text.trim(),
                                areaController.text.trim(),
                                landmarkController.text.trim());

                            if (context.mounted) {
                              Navigator.pop(context);
                              Utilities.showCommonSnackBar(
                                  context, "Address added successfully",
                                  icon: Icons.done);
                            }
                            await locationProvider.getAllLocation();

                            // if (context.mounted) {
                            //   Utilities.showCommonSnackBar(
                            //       context, "Address added successfully",
                            //       icon: Icons.done);
                            // }
                            // await locationProvider.getAllLocation();
                            // Future.delayed(Duration(seconds: 1), () {
                            //   if (context.mounted) {
                            //     Navigator.pop(context);
                            //   }
                            // });
                          } catch (e) {
                            debugPrint(e.toString());
                            if (context.mounted) {
                              Utilities.showCommonSnackBar(
                                  context, e.toString(),
                                  color: Colors.red, durationMilliseconds: 500);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: CommonColor.primaryColor),
                      child: Consumer<LocationProvider>(
                          builder: (context, locationProvider, child) {
                        return locationProvider.isCreateShippingLocationLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
