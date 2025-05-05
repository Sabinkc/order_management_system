import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/forget_password_reset_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ForgetpasswordOtpVerificationScreen extends StatefulWidget {
  final String email;
  const ForgetpasswordOtpVerificationScreen({super.key, required this.email});

  @override
  State<ForgetpasswordOtpVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<ForgetpasswordOtpVerificationScreen> {
  final TextEditingController pinController = TextEditingController();
  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),

            Text(
              "Please enter the forget password verification code sent to ${widget.email}",
              style: TextStyle(
                  color: CommonColor.darkGreyColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 30,
            ),
            Pinput(
              controller: pinController,
              length: 5,
              keyboardType: TextInputType.number,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CommonColor.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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
                    if (pinController.text.length < 5) {
                      Utilities.showCommonSnackBar(
                          context, "Please input all the fileds!");
                      return;
                    }
                    try {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);

                      final response = await authProvider.forgetPassCheckOtp(
                          widget.email, pinController.text);

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
                                      ForgetPasswordResetScreen(email: widget.email,otp: pinController.text,)));
                          // Utilities.showCommonSnackBar(context, message,
                          //     durationMilliseconds: 1000);
                        }
                      } else {
                        String message = response["message"];

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
                    return authProvider.isForgetPasswordCheckOtpLoading == true
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
            // Text(
            //   "Resend code",
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // )
          ],
        ),
      ),
    );
  }
}
