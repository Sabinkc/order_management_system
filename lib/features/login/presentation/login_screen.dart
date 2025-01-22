import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/features/dashboard/presentation/dashboard_screen.dart';
import 'package:order_management_system/features/register/presentation/signup_screen.dart';

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
                    0.27, // Start the green background below the "Login" text
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
                      height: screenHeight * 0.13,
                    ),
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
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
                                    builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: screenHeight * 0.09),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonTextfield(
                            hintText: "Johndoe@gmail.com",
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonTextfield(
                            hintText: "••••••••",
                            prefixIcon: Icons.lock,
                            suffixIcon: Icons.visibility,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget password?",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
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
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Divider(
                                          color: CommonColor.primaryColor))),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Or login with",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Divider(
                                          color: CommonColor.primaryColor))),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: screenHeight * 0.065,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
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
                          SizedBox(height: screenHeight * 0.05),
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
                              Text(
                                "Privacy Policy ",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: CommonColor.primaryColor),
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
                                style: TextStyle(
                                    fontSize: 9,
                                    color: CommonColor.primaryColor),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "Condition",
                              style: TextStyle(
                                  fontSize: 9, color: CommonColor.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
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
