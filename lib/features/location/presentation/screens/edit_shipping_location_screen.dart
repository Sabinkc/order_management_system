import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/domain/location_provider.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:provider/provider.dart';

class EditShippingLocationScreen extends StatefulWidget {
  final int index;
  const EditShippingLocationScreen({super.key, required this.index});

  @override
  State<EditShippingLocationScreen> createState() =>
      _EditShippingLocationScreenState();
}

class _EditShippingLocationScreenState
    extends State<EditShippingLocationScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController streetController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    fullNameController.text = locationProvider.addresses[widget.index].fullName;

    phoneController.text = locationProvider.addresses[widget.index].phone;
    emailController.text = locationProvider.addresses[widget.index].email;
    stateController.text = locationProvider.addresses[widget.index].state;
    cityController.text = locationProvider.addresses[widget.index].city;
    streetController.text = locationProvider.addresses[widget.index].street;
    landmarkController.text = locationProvider.addresses[widget.index].landmark;
    super.initState();
  }

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
              text: "Edit Shippi",
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

                SizedBox(
                    width: screenWidth * 0.42,
                    child: CommonLocationTextformField(
                        controller: fullNameController,
                        hintText: "First Name")),

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
                            controller: stateController,
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
                            controller: streetController,
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
                // Consumer<LocationProvider>(
                //     builder: (context, locationProvider, child) {
                //   return Padding(
                //     padding: EdgeInsets.only(left: 8),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Address Category",
                //           style: TextStyle(
                //               fontSize: 15, fontWeight: FontWeight.bold),
                //         ),
                //         Row(
                //           spacing: 10,
                //           children: [
                //             Row(
                //               spacing: 3,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     locationProvider.editCategory(
                //                         widget.index, "home");
                //                   },
                //                   child: locationProvider
                //                               .addresses[widget.index]
                //                               .category ==
                //                           "home"
                //                       ? Icon(
                //                           Icons.check_circle,
                //                           color: CommonColor.primaryColor,
                //                           size: 28,
                //                         )
                //                       : Icon(
                //                           Icons.circle_outlined,
                //                           color: CommonColor.primaryColor,
                //                           size: 28,
                //                         ),
                //                 ),
                //                 locationProvider
                //                             .addresses[widget.index].category ==
                //                         "home"
                //                     ? Text(
                //                         "Home",
                //                         style: TextStyle(
                //                             fontSize: 18,
                //                             color: CommonColor.primaryColor),
                //                       )
                //                     : Text(
                //                         "Home",
                //                         style: TextStyle(
                //                             fontSize: 18,
                //                             color: CommonColor.darkGreyColor),
                //                       )
                //               ],
                //             ),
                //             Row(
                //               spacing: 3,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     locationProvider.editCategory(
                //                         widget.index, "office");
                //                   },
                //                   child: locationProvider
                //                               .addresses[widget.index]
                //                               .category ==
                //                           "office"
                //                       ? Icon(
                //                           Icons.check_circle,
                //                           color: CommonColor.primaryColor,
                //                           size: 28,
                //                         )
                //                       : Icon(
                //                           Icons.circle_outlined,
                //                           color: CommonColor.primaryColor,
                //                           size: 28,
                //                         ),
                //                 ),
                //                 locationProvider
                //                             .addresses[widget.index].category ==
                //                         "office"
                //                     ? Text(
                //                         "Office",
                //                         style: TextStyle(
                //                             fontSize: 18,
                //                             color: CommonColor.primaryColor),
                //                       )
                //                     : Text(
                //                         "Office",
                //                         style: TextStyle(
                //                             fontSize: 18,
                //                             color: CommonColor.darkGreyColor),
                //                       ),
                //               ],
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   );
                // }),
                // SizedBox(
                //   height: screenHeight * 0.04,
                // ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (fullNameController.text.trim().isEmpty ||
                          phoneController.text.trim().isEmpty ||
                          emailController.text.trim().isEmpty ||
                          stateController.text.trim().isEmpty ||
                          cityController.text.trim().isEmpty ||
                          streetController.text.trim().isEmpty ||
                          landmarkController.text.trim().isEmpty) {
                        Utilities.showCommonSnackBar(
                            context, "All fields are required!",
                            color: Colors.red, durationMilliseconds: 500);
                      } else {
                        final locationProvider = Provider.of<LocationProvider>(
                            context,
                            listen: false);
                        locationProvider.editAddress(
                          widget.index,
                          firstName: fullNameController.text.trim(),
                          phone: phoneController.text.trim(),
                          email: emailController.text.trim(),
                          state: stateController.text.trim(),
                          city: cityController.text.trim(),
                          street: streetController.text.trim(),
                          landmark: landmarkController.text.trim(),
                        );
                        // firstNameController.clear();
                        // lastNameController.clear();
                        // phoneController.clear();
                        // emailController.clear();
                        // stateController.clear();
                        // cityController.clear();
                        // streetController.clear();
                        // landmarkController.clear();
                        Utilities.showCommonSnackBar(
                            context, "Address edited successfully",
                            icon: Icons.done);
                        Future.delayed(Duration(seconds: 1), () {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
