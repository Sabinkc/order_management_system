import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/location/presentation/screens/add_shipping_loation_screen.dart';

class ShippingLocationScreen extends StatelessWidget {
  const ShippingLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Shipping",
            style: TextStyle(
                fontSize: 22,
                color: CommonColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "Location",
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
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddShippingLoationScreen()));
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
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: CommonColor.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 100,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.location_on,
                                    color: CommonColor.primaryColor,
                                  ),
                                ),
                                Text(
                                  "Kathmandu",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "(977 987654321)",
                              style: TextStyle(
                                  color: CommonColor.darkGreyColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Text(
                              "P7PW-664, Kathmandu 44600",
                              style: TextStyle(
                                  color: CommonColor.darkGreyColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 32, top: 5),
                            child: Row(
                              spacing: 100,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(
                                      "Default shipping address",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.red),
                                    ),
                                  )),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddShippingLoationScreen()));
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.orangeAccent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
