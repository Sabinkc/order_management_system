import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Ord",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "ers",
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order History",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text("Sort"),
                      Icon(Icons.arrow_drop_down_outlined)
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
