import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:order_management_system/features/signup/domain/checkbox_provider.dart';
import 'package:order_management_system/features/signup/domain/signup_textfield_provider.dart';
import 'package:order_management_system/features/signup/presentation/widgets/checkbox_widget_signup.dart';

import 'package:provider/provider.dart';

class TextfieldWidgetSignup extends StatelessWidget {
  const TextfieldWidgetSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final fullnameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

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
          controller: fullnameController,
          hintText: "John Doe",
          prefixIcon: Icons.person,
        ),
        SizedBox(height: screenHeight * 0.03),
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
          controller: emailController,
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
        ),
        SizedBox(height: screenHeight * 0.03),
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
            controller: passwordController,
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
        SizedBox(height: screenHeight * 0.025),
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
            controller: confirmPasswordController,
            isObscure: provider.isConfirmObscure,
            onSuffixPressed: provider.switchConfirmObscure,
            hintText: "••••••••",
            prefixIcon: Icons.lock,
            suffixIcon: provider.isConfirmObscure == true
                ? Icons.visibility_off
                : Icons.visibility,
          );
        }),
        SizedBox(height: screenHeight * 0.015),
        const CheckboxWidgetSignup(),
        SizedBox(height: screenHeight * 0.015),
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.white,
                      backgroundColor: CommonColor.primaryColor),
                  onPressed: () async {
                    final logger = Logger();
                    signup(
                        context,
                        fullnameController,
                        emailController,
                        passwordController,
                        confirmPasswordController,
                        logger,
                        authProvider);
                  },
                  child: authProvider.isSignupLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
            );
          },
        ),
      ],
    );
  }

//Logical part
//sign up function
  Future signup(
      BuildContext context,
      TextEditingController fullnameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController,
      Logger logger,
      AuthProvider provider) async {
    final fullname = fullnameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CommonColor.snackbarColor,
          content: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(
                Icons.warning_rounded,
                color: CommonColor.whiteColor,
                size: 30,
              ),
              Expanded(
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "Please enter the required fields!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CommonColor.snackbarColor,
          content: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(
                Icons.warning_rounded,
                color: CommonColor.whiteColor,
                size: 30,
              ),
              Expanded(
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "Passwords donot match.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    final checkBoxProvider =
        Provider.of<CheckboxProvider>(context, listen: false);
    if (checkBoxProvider.isSelected == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CommonColor.snackbarColor,
          content: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(
                Icons.warning_rounded,
                color: CommonColor.whiteColor,
                size: 30,
              ),
              Expanded(
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "You must agree to the terms and conditions to continue.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    final response = await provider.signup(fullname, email, password);
    logger.i("Response:$response");

    if (response["success"] == true) {
      if (context.mounted) {
        final SettingsProvider profileProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        final name = response["data"]["data"]["profile"]["name"];
        final email = response["data"]["data"]["profile"]["email"];

        profileProvider.addProfileData(name, email);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => LandingScreen()),
        );
      }
    } else {
      String errorMessage = "Unable to signup!";

      if (response["message"] is Map &&
          response["message"].containsKey("email")) {
        errorMessage = response["message"]["email"][0]; // Extract email error
        logger.i("error message: $errorMessage");
      } else if (response["message"] is Map &&
          response["message"].containsKey("password")) {
        errorMessage =
            response["message"]["password"][0]; // Extract email error
        logger.i("error message: $errorMessage");
      } else if (response["message"] is String) {
        errorMessage = response["message"];
        logger.i("error message: $errorMessage");
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CommonColor.snackbarColor,
            content: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: CommonColor.whiteColor,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    errorMessage,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
