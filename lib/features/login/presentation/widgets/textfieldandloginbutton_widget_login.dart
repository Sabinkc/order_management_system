import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class TextfieldandloginbuttonWidgetLogin extends StatefulWidget {
  const TextfieldandloginbuttonWidgetLogin({super.key});

  @override
  State<TextfieldandloginbuttonWidgetLogin> createState() =>
      _TextfieldandloginbuttonWidgetLoginState();
}

class _TextfieldandloginbuttonWidgetLoginState
    extends State<TextfieldandloginbuttonWidgetLogin> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final logger = Logger();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        CommonTextfield(
          controller: emailController,
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
        ),
        SizedBox(height: screenHeight * 0.04),
        Text(
          "Password",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Consumer<LoginTextfieldProvider>(builder: (context, provider, child) {
          return CommonTextfield(
            controller: passwordController,
            isObscure: provider.isObscure,
            onSuffixPressed: provider.switchObscure,
            hintText: "••••••••",
            prefixIcon: Icons.lock,
            suffixIcon: provider.isObscure == true
                ? Icons.visibility_off
                : Icons.visibility,
          );
        }),
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
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Consumer<AuthProvider>(
          builder: (context, provider, child) {
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
                    login(context, emailController, passwordController, logger,
                        provider);
                  },
                  child: provider.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
            );
          },
        ),
      ],
    );
  }

//logical part
  Future login(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      Logger logger,
      AuthProvider provider) async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
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

    final response = await provider.login(email, password);
    logger.i("Response:$response");

    if (response["success"] == true) {
      if (context.mounted) {
        final SettingsProvider profileProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        final name = response["data"]["profile"]["name"];
        final email = response["data"]["profile"]["email"];

        profileProvider.addProfileData(name, email);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
          (route) => false,
        );
      }
    } else {
      String errorMessage = "Unable to login!";

      if (response["message"] is Map &&
          response["message"].containsKey("email")) {
        errorMessage = response["message"]["email"][0]; // Extract email error
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
