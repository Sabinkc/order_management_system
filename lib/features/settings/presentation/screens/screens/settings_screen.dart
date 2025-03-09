import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_screen.dart';
import 'package:order_management_system/features/location/presentation/screens/add_shipping_loation_screen.dart';
import 'package:order_management_system/features/login/data/google_signin_api_service.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/my_profile_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/reset_password_screen.dart';
import 'package:order_management_system/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: CommonColor.primaryColor,
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Settings",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child:
                Consumer<SettingsProvider>(builder: (context, provider, child) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(children: [
                    Positioned(
                      top: screenHeight * 0.09,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: double
                            .infinity, // Ensures it covers the remaining area
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/images/profile.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(provider.userName,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(provider.userEmail,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CommonColor.darkGreyColor)),
                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              leading: Icon(
                                Icons.build_outlined,
                                color: CommonColor.primaryColor,
                                size: 28,
                              ),
                              title: Text(
                                "General",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: CommonColor.primaryColor,
                                size: 30,
                              ),
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyProfileScreen()));
                                  },
                                  leading: Icon(
                                    Icons.person_2_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "My Profile",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddShippingLoationScreen()));
                                  },
                                  leading: Icon(
                                    Icons.location_history_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Address",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPasswordScreen()));
                                  },
                                  leading: Icon(
                                    Icons.change_circle_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              leading: Icon(
                                MingCute.list_ordered_line,
                                color: CommonColor.primaryColor,
                                size: 28,
                              ),
                              title: Text(
                                "Orders",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: CommonColor.primaryColor,
                                size: 30,
                              ),
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceScreen()));
                                  },
                                  leading: Icon(
                                    MingCute.inventory_line,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Invoices",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.history,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Order History",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              leading: Icon(
                                MingCute.settings_1_line,
                                color: CommonColor.primaryColor,
                                size: 29,
                              ),
                              title: Text(
                                "System Settings",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: CommonColor.primaryColor,
                                size: 30,
                              ),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.notification_important_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Push Notification",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                  trailing: Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                        activeColor: CommonColor.primaryColor,
                                        inactiveThumbColor:
                                            CommonColor.mediumGreyColor,
                                        value: provider.notficationSwitchState,
                                        onChanged: (bool? value) {
                                          provider.switchPushNotification();
                                        }),
                                  ),
                                ),
                                Consumer<LocalizationProvider>(builder:
                                    (context, localizationProvider, child) {
                                  return ListTile(
                                      leading: Icon(
                                        Icons.language_outlined,
                                        color: CommonColor.primaryColor,
                                      ),
                                      title: Text(
                                        "Language",
                                        style: TextStyle(
                                            color: CommonColor.darkGreyColor),
                                      ),
                                      trailing: IntrinsicWidth(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Row(
                                            children: [
                                              Text("Eng"),
                                              Transform.scale(
                                                scale: 0.8,
                                                child: Switch(
                                                  activeColor:
                                                      CommonColor.primaryColor,
                                                  inactiveThumbColor:
                                                      CommonColor
                                                          .mediumGreyColor,
                                                  value: localizationProvider
                                                          .locale
                                                          .languageCode ==
                                                      "ja",
                                                  onChanged:
                                                      (bool isJapanese) async {
                                                    String newLanguage = isJapanese
                                                        ? "ja"
                                                        : "en"; // Toggle language
                                                    localizationProvider
                                                        .setLocale(Locale(
                                                            newLanguage)); // Update language
                                                  },
                                                ),
                                              ),
                                              Text("Jap"),
                                            ],
                                          ),
                                        ),
                                      ));
                                }),
                                ListTile(
                                  onTap: () {
                                    showLogoutDialogAndLogout(context);
                                  },
                                  leading: Icon(
                                    Icons.logout_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              leading: SvgPicture.asset(
                                  "assets/icons/help_and_support.svg"),
                              title: Text(
                                "Contact & Support",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: CommonColor.primaryColor,
                                size: 30,
                              ),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.contact_page_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Contact",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.question_answer_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "FAQs",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.report_problem_outlined,
                                    color: CommonColor.primaryColor,
                                  ),
                                  title: Text(
                                    "Report Issues",
                                    style: TextStyle(
                                        color: CommonColor.darkGreyColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            }),
          );
        }));
  }

  //Logical part
  //dialog to confirm logout

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
                              final GoogleSignInApiService
                                  googleSignInApiService =
                                  GoogleSignInApiService();
                              googleSignInApiService.logOut(context);
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

//function to show language dialog
  showLanguageDialogue(
      BuildContext context, LocalizationProvider localizationProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "en",
                        groupValue: localizationProvider.locale.languageCode,
                        onChanged: (value) {
                          localizationProvider.setLocale(Locale(value!));
                          Navigator.pop(context); // Close dialog
                        },
                      ),
                      Text("English"),
                    ],
                  ),

                  // Japanese Radio Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "ja",
                        groupValue: localizationProvider.locale.languageCode,
                        onChanged: (value) {
                          localizationProvider.setLocale(Locale(value!));
                          Navigator.pop(context); // Close dialog
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
  }

//logout function
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
