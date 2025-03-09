import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColor.primaryColor,
              size: 20,
            )),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Reset password",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "New Password",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(
                controller: newPasswordController,
                hintText: "Enter your new password"),
            SizedBox(height: screenHeight * 0.03),
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
            CommonLocationTextformField(
                controller: confirmPasswordController,
                hintText: "Confirm your new password"),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  final newPassword = newPasswordController.text.trim();
                  final confirmPassword = confirmPasswordController.text.trim();
                  if (newPassword.isEmpty || confirmPassword.isEmpty) {
                    Utilities.showCommonSnackBar(
                        color: Colors.red, context, "All fields are required!");
                  } else if (!(newPassword == confirmPassword)) {
                    Utilities.showCommonSnackBar(
                        color: Colors.red, context, "Password doesnot match!");
                  } else if (newPassword.length < 8) {
                    Utilities.showCommonSnackBar(
                        color: Colors.red,
                        context,
                        "Password must be 8 characters long");
                  } else {
                    Utilities.showCommonSnackBar(
                        context, "Password reset successful!");
                    Future.delayed(Duration(seconds: 1), () {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: CommonColor.primaryColor),
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
