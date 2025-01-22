import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'package:lottie/lottie.dart';

import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/features/dashboard/presentation/dashboard_screen.dart';

import 'package:order_management_system/features/register/presentation/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    0.25, // Start the green background below the "Login" text
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.white, // Replace with your desired green color
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    // Animation at the top
                    Center(
                      child: Lottie.asset(
                        "assets/animations/login_animation.json",
                        height: screenHeight * 0.35,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Login text
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: CommonColor.primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: CommonColor.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
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
                                  "LogIn",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
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
                                border: Border.all(
                                    color: CommonColor.primaryColor,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 4,
                                  children: [
                                    Brand(Brands.google, size: 30),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
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
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
