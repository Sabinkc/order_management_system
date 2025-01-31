import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Inv",
            style: TextStyle(
                fontSize: 22,
                color: CommonColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "oice",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Invoice screen"),
      ),
    );
  }
}
