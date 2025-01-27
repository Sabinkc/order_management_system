import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';

class AddShippingLoationScreen extends StatelessWidget {
  const AddShippingLoationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "AddShippi",
            style: TextStyle(
                fontSize: 22,
                color: CommonColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "ngLocation",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Recepient's Name",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(hintText: "Input the real name"),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Phone Number",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(
                hintText: "Input the real phone number"),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Region",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(hintText: "Input the region"),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Address",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(hintText: "Input the address"),
            SizedBox(height: screenHeight * 0.03),
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
    );
  }
}
