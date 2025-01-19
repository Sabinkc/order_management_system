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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Center(
                  child: Lottie.asset("assets/login_animation.json",
                      height: screenHeight * 0.35)),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "Login",
                style: TextStyle(
                    color: CommonColor.primaryColor,
                    fontSize: 50,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Please login to continue!",
                style: TextStyle(
                  fontSize: 20,
                  color: CommonColor.primaryColor,
                ),
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
                height: screenHeight * 0.01,
              ),
              Text(" Forgot password?"),
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
                children: [
                  Expanded(child: Divider()),
                  Text(" OR CONTINUE WITH "),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: screenHeight * 0.06,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300]),
                    child: Brand(Brands.google),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text("SignUp"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
