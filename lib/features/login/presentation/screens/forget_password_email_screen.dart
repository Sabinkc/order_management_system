import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/forgetpassword_otp_verification_screen.dart';
import 'package:provider/provider.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({super.key});

  @override
  State<ForgetPasswordEmailScreen> createState() =>
      _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email address!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return CommonTextfield(
                controller: emailController,
                hintText: "Enter your email ",
                prefixIcon: Icons.email,
                isEnabled: authProvider.isForgetPasswordOtpLoading == true
                    ? false
                    : true,
              );
            }),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: CommonColor.primaryColor),
                  onPressed: () async {
    

                    try {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);

                      final response = await authProvider
                          .forgetPassSendOtp(emailController.text.trim());

                      if (response["success"] == true) {
                        // String message = response["message"];
                        if (context.mounted) {
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetpasswordOtpVerificationScreen(
                                        email: emailController.text.trim(),
                                      )));
                          // Utilities.showCommonSnackBar(context, message,
                          //     durationMilliseconds: 1000);
                        }
                      } else {
                        String message = response["message"]
                            .entries
                            .first
                            .value[0]
                            .toString();
                        if (context.mounted) {
                          Utilities.showCommonSnackBar(context, message);
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Utilities.showCommonSnackBar(context, e.toString());
                      }
                    }
                  },
                  child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return authProvider.isForgetPasswordOtpLoading == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          );
                  })),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
