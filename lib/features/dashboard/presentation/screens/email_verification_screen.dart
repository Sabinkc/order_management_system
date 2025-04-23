import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
              "Email Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<SettingsProvider>(
                builder: (context, settingProvider, child) {
              return Text(
                "We have send the email verification code to ${settingProvider.profile.email}",
                style: TextStyle(
                    color: CommonColor.darkGreyColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              );
            }),
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
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return SizedBox(
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
                        logger.log("pincontroller val: ${pinController.text}");
                        final response =
                            await authProvider.verifyEmail(pinController.text);
                        logger.log("UI response: $response");

                        if (response["success"] == true) {
                          String message = response["message"];
                          if (context.mounted) {
                            final settingProvider =
                                Provider.of<SettingsProvider>(context,
                                    listen: false);
                            await settingProvider.getProfile();
                            if (!context.mounted) {
                              return;
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Utilities.showCommonSnackBar(context, message,
                                durationMilliseconds: 1000);
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
                    child: authProvider.isVerifyEmailLoading == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
              );
            }),
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
