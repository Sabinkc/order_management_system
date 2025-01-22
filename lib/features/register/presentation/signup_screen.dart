import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/dashboard/presentation/dashboard_screen.dart';
import 'package:order_management_system/features/login/presentation/login_screen.dart';
import 'package:order_management_system/features/register/domain/checkbox_provider.dart';
import 'package:order_management_system/features/register/domain/signup_textfield_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CommonColor.primaryColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: screenHeight *
                    0.23, // Start the green background below the "Login" text
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: CommonColor
                        .commonGreyColor, // Replace with your desired green color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              // Main content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a user? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Full Name",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          Consumer<SignupTextfieldProvider>(
                              builder: (context, provider, child) {
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          Consumer<SignupTextfieldProvider>(
                              builder: (context, provider, child) {
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
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Consumer<CheckboxProvider>(
                                builder: (context, provider, child) {
                                  return Checkbox(
                                      activeColor: CommonColor.primaryColor,
                                      value: provider.isSelected,
                                      onChanged: (value) {
                                        provider.switchSelection();
                                      });
                                },
                              ),
                              Text(
                                "I agree to the ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                              Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: CommonColor.primaryColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.065,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    foregroundColor: Colors.white,
                                    backgroundColor: CommonColor.primaryColor),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              DashboardScreen()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
