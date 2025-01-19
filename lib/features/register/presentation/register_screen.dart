import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Center(
                  child: Lottie.asset("assets/register_animation.json",
                      height: screenHeight * 0.25)),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "Register",
                style: TextStyle(
                    color: CommonColor.primaryColor,
                    fontSize: 50,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Please register to login!",
                style: TextStyle(
                  fontSize: 20,
                  color: CommonColor.primaryColor,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CommonTextfield(
                hintText: "Username",
                prefixIcon: Icons.person,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CommonTextfield(
                hintText: "Email",
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CommonTextfield(
                hintText: "Password",
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
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
              Divider(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CommonButton(
                buttonText: "Log In",
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
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
    );
  }
}
