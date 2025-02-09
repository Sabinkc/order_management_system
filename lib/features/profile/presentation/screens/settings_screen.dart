import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';

import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:order_management_system/features/profile/domain/profile_data_provider.dart';
import 'package:order_management_system/localization/localization_provider.dart';

import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Sett",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "ings",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Consumer<ProfileDataProvider>(
              builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(provider.userName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text(provider.userEmail,
                      style: TextStyle(
                          fontSize: 16, color: CommonColor.mediumGreyColor)),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text(
                      "My Profile",
                      style: TextStyle(),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text(
                      "My address",
                      style: TextStyle(),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text(
                      "My orders",
                      style: TextStyle(),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                  Consumer<LocalizationProvider>(
                    builder: (context, localizationProvider, child) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Choose a language:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    // English Radio Button
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: "en",
                                              groupValue: localizationProvider
                                                  .locale.languageCode,
                                              onChanged: (value) {
                                                localizationProvider
                                                    .setLocale(Locale(value!));
                                                Navigator.pop(
                                                    context); // Close dialog
                                              },
                                            ),
                                            Text("English"),
                                          ],
                                        ),

                                        // Japanese Radio Button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: "ja",
                                              groupValue: localizationProvider
                                                  .locale.languageCode,
                                              onChanged: (value) {
                                                localizationProvider
                                                    .setLocale(Locale(value!));
                                                Navigator.pop(
                                                    context); // Close dialog
                                              },
                                            ),
                                            Text("Japanese"),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        leading: Icon(Icons.language),
                        title: Text("Languages"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                  ListTile(
                    onTap: () {
                      showLogoutDialogAndLogout(context);
                    },
                    leading: Icon(Icons.logout_outlined),
                    title: Text(
                      "Log out",
                      style: TextStyle(),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(
                    height: 0,
                    color: CommonColor.commonGreyColor,
                  ),
                ],
              ),
            );
          }),
        ));
  }

  showLogoutDialogAndLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              titlePadding: EdgeInsets.only(
                top: 12,
                bottom: 10,
              ),
              contentPadding: EdgeInsets.only(bottom: 12),
              title: Text(
                "Confirm to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Are you sure you want to log out?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: CommonColor.darkGreyColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: CommonColor.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: CommonColor.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: CommonColor.primaryColor,
                            ),
                            onPressed: () {
                              logout(context);
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  Future<void> logout(BuildContext context) async {
    final logger = Logger();
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    // Show the "Logging out" alert box
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text(
                    "Logging out",
                    style: TextStyle(
                        color: CommonColor.darkGreyColor, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Perform logout
    bool logoutSuccessful = await authProvider.logout();

    // Dismiss the "Logging out" alert box
    if (context.mounted) {
      Navigator.pop(context); // Dismiss the "Logging out" dialog
    }

    // Handle logout result
    if (logoutSuccessful) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      // Logout failed - Show "Logged out fail" alert box
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(
                child: Center(
                  child: Text(
                    "Something went wrong. Please try again later!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: CommonColor.darkGreyColor, fontSize: 18),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "OK",
                      style: TextStyle(color: CommonColor.darkGreyColor),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
      logger.i("Logout failed!");
    }
  }
}
