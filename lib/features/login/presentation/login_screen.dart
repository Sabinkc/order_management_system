import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:order_management_system/common/common_button.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/features/register/presentation/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CommonColor.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight *
                0.25, // Start the green background below the "Login" text
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Replace with your desired green color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  // Animation at the top
                  Center(
                    child: Lottie.asset(
                      "assets/login_animation.json",
                      height: screenHeight * 0.35,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Login text
                  Text(
                    "Login",
                    style: TextStyle(
                      color: CommonColor.primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Form container (overlapping the green background)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CommonTextfield(
                          hintText: "Email",
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CommonTextfield(
                          hintText: "Password",
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.visibility,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.white, // White text for contrast
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CommonButton(buttonText: "Log In"),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR CONTINUE WITH",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: screenHeight * 0.06,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],
                            ),
                            child: Center(
                              child: Brand(Brands.google, size: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text("SignUp"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
