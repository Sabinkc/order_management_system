import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class BottomTextLogin extends StatelessWidget {
  const BottomTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By using this app, you agree to our ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Privacy Policy ",
                style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
              ),
            ),
            Text(
              "and ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Colors.black),
            ),
            Text(
              "Terms of",
              style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
            ),
          ],
        ),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Text(
              "Condition",
              style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
