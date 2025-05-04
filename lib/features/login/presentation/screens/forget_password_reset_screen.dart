import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';

class ForgetPasswordResetScreen extends StatelessWidget {
  const ForgetPasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.scaffoldbackgroundColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: CommonColor.primaryColor,
                )),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset password!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  CommonLocationTextformField(
                    hintText: "Enter new password",
                    fillColor: Colors.white,
                  ),
                  CommonLocationTextformField(
                    hintText: "Confirm new password",
                    fillColor: Colors.white,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: CommonColor.primaryColor),
                      onPressed: () async {},
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
