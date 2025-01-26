import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class AppbarDashboard extends StatelessWidget {
  const AppbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Order",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "Management",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {},
          ),
          actions: [
            const SizedBox(
              width: 10,
            ),
          ],
        );
  }
}