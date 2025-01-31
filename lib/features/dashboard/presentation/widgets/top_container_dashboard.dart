import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/location/presentation/screens/shipping_location_screen.dart';

class TopContainerDashboard extends StatelessWidget {
  const TopContainerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ShippingLocationScreen()));
        },
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 78,
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                        ))
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 24,
                  color: Colors.deepPurple,
                ),
              ],
            )),
      ),
    );
  }
}
