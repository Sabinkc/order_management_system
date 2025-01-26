import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class DividerTextLogin extends StatelessWidget {
  const DividerTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Divider(color: CommonColor.primaryColor))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Or login with",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Divider(color: CommonColor.primaryColor))),
      ],
    );
  }
}
