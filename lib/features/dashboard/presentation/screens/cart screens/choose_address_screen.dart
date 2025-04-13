import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class ChooseAddressScreen extends StatelessWidget {
  const ChooseAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(child: Text("Choose address")),
    );
  }
}
