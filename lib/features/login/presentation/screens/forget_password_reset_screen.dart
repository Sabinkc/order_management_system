import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ForgetPasswordResetScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ForgetPasswordResetScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ForgetPasswordResetScreen> createState() =>
      _ForgetPasswordResetScreenState();
}

class _ForgetPasswordResetScreenState extends State<ForgetPasswordResetScreen> {
  final TextEditingController passwordController = TextEditingController();
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
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return CommonLocationTextformField(
                      controller: passwordController,
                      hintText: "Enter new password",
                      fillColor: Colors.white,
                      isEnabled:
                          authProvider.isresetForgettenPasswordLoading == true
                              ? false
                              : true,
                    );
                  }),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: CommonColor.primaryColor),
                        onPressed: () async {
                          if (passwordController.text.isEmpty) {
                            Utilities.showCommonSnackBar(context,
                                "Please enter all the required fields");
                            return;
                          }

                          try {
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            final response =
                                await authProvider.resetForgottenPassword(
                                    widget.email,
                                    passwordController.text.trim(),
                                    widget.otp);

                            if (response["success"] == true) {
                              // String message = response["message"];
                              if (context.mounted) {
                                if (!context.mounted) {
                                  return;
                                }
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                                Utilities.showCommonSnackBar(context,
                                    "Password reset successfull. Please login with new password",
                                    durationMilliseconds: 2000);
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
                              Utilities.showCommonSnackBar(
                                  context, e.toString());
                            }
                          }
                        },
                        child: Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                          return authProvider.isresetForgettenPasswordLoading ==
                                  true
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                );
                        })),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
