import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CommonButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.06,
          decoration: BoxDecoration(
              color: CommonColor.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
