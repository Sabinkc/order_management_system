import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:order_management_system/common/common_button.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/login/presentation/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CommonColor.primaryColor,
        body: Stack(
          children: [
            Positioned(
                top: screenHeight * 0.2,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //scrollable
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    //animation at the top
                    Center(
                        child: Lottie.asset("assets/register_animation.json",
                            height: screenHeight * 0.25)),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //text below the animation
                    Text(
                      "Register",
                      style: TextStyle(
                          color: CommonColor.primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w600),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //textfield for username
                    CommonTextfield(
                      hintText: "Username",
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //textfield for email
                    CommonTextfield(
                      hintText: "Email",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //textfield for password
                    CommonTextfield(
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //textfield to confirm password
                    CommonTextfield(
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //divider
                    Divider(),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //login button
                    CommonButton(
                      buttonText: "Log In",
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    //text at the last
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("LogIn"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
