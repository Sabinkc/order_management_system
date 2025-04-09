import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Reset password",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Old Password",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            CommonLocationTextformField(
                fillColor: Colors.white,
                controller: oldPasswordController,
                hintText: "Enter your old password"),
            SizedBox(height: screenHeight * 0.03),
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
                fillColor: Colors.white,
                controller: newPasswordController,
                hintText: "Enter your new password"),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                  onPressed: () async {
                    final newPassword = newPasswordController.text.trim();
                    final oldPassword = oldPasswordController.text.trim();
                    if (oldPassword.isEmpty || newPassword.isEmpty) {
                      Utilities.showCommonSnackBar(
                          context, "All fields are required!",
                          color: Colors.red, durationMilliseconds: 500);
                    } else {
                      try {
                        final settingsProvider = Provider.of<SettingsProvider>(
                            context,
                            listen: false);
                        await settingsProvider.changePassword(
                            oldPassword, newPassword);
                        if (!context.mounted) return;
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        final email = settingsProvider.profile.email;
                        await authProvider.login(email, newPassword);

                        if (context.mounted) {
                          await Utilities.showCommonSnackBar(
                              context, "Password changed successfully",
                              icon: Icons.done);
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                        if (context.mounted) {
                          Utilities.showCommonSnackBar(context, e.toString(),
                              color: Colors.red, durationMilliseconds: 1000);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: CommonColor.primaryColor),
                  child: Consumer<SettingsProvider>(
                      builder: (context, settingsProvider, child) {
                    return settingsProvider.isPasswordResetting == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Reset",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
