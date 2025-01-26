import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/signup/domain/signup_textfield_provider.dart';
import 'package:provider/provider.dart';

class TextfieldWidgetSignup extends StatelessWidget {
  const TextfieldWidgetSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Full Name",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        CommonTextfield(
          hintText: "John Doe",
          prefixIcon: Icons.person,
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Email",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        CommonTextfield(
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Password",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Consumer<SignupTextfieldProvider>(builder: (context, provider, child) {
          return CommonTextfield(
            isObscure: provider.isPasswordObscure,
            onSuffixPressed: provider.switchPasswordObscure,
            hintText: "••••••••",
            prefixIcon: Icons.lock,
            suffixIcon: provider.isPasswordObscure == true
                ? Icons.visibility_off
                : Icons.visibility,
          );
        }),
        SizedBox(height: screenHeight * 0.015),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Min, 8 char, inc 1 uppercase and lowercase letter, 1 number and 1 special character",
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                  color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Confirm Password",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Consumer<SignupTextfieldProvider>(builder: (context, provider, child) {
          return CommonTextfield(
            isObscure: provider.isConfirmObscure,
            onSuffixPressed: provider.switchConfirmObscure,
            hintText: "••••••••",
            prefixIcon: Icons.lock,
            suffixIcon: provider.isConfirmObscure == true
                ? Icons.visibility_off
                : Icons.visibility,
          );
        }),
      ],
    );
  }
}
