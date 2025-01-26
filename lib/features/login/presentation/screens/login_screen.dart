import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/login/presentation/widgets/bottom_text_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/divider_text_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/google_button_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/login_button.dart';
import 'package:order_management_system/features/login/presentation/widgets/textfield_widget_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/top_text_login.dart';

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
                    TopTextLogin(),
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextfieldWidgetLogin(),
                          SizedBox(height: screenHeight * 0.01),
                          LoginButton(),
                          SizedBox(height: screenHeight * 0.05),
                          DividerTextLogin(),
                          SizedBox(height: screenHeight * 0.05),
                          GoogleButtonLogin(),
                          SizedBox(height: screenHeight * 0.05),
                          BottomTextLogin(),
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
