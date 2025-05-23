import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/location/presentation/screens/shipping_location_screen.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:order_management_system/features/orders/presentation/screens/order_screen.dart';
import 'package:order_management_system/features/login/data/google_signin_api_service.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:order_management_system/features/settings/data/push_notification_shared_pref.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/contact_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/faqs_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/my_profile_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/report_issue_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/reset_password_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/settings_invoice_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/view_avatar_screen.dart';
import 'package:order_management_system/localization/localization_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/localization/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      loadAvatar();
      if (!mounted) return;
      final settingProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await settingProvider.getProfile();
      final sharedPrefNotificationValue =
          await PushNotificationSharedPref.getNotificationOptIn();
      settingProvider.notficationSwitchState = sharedPrefNotificationValue;
    });
    super.initState();
  }

  Future loadAvatar() async {
    try {
      final profileProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await profileProvider.loadProfileAvatar();
    } catch (e) {
      if (!mounted) return;
      logger.log("$e");
      // Utilities.showCommonSnackBar(context, "$e");
    }
  }

  Future<void> updateNotificationSubscription(bool isSubscribed) async {
    if (isSubscribed) {
      await OneSignal.User.pushSubscription.optIn(); // Enables notifications
    } else {
      await OneSignal.User.pushSubscription.optOut(); // Disables notifications
    }
  }

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
              text: S.current.settings,
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
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Center(
                            child: Consumer<SettingsProvider>(
                              builder: (context, profileProvider, child) {
                                return GestureDetector(
                                    onTap: () {
                                      if (profileProvider.avatarBytes == null) {
                                        Utilities.showCommonSnackBar(
                                            context, "No avatar to view");
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAvatarScreen()));
                                      }
                                    },
                                    child: Column(children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: _buildAvatarImage(
                                                  profileProvider),
                                            ),
                                          ),
                                          if (profileProvider
                                                  .isUpdateAvatarLoading ||
                                              profileProvider.isAvatarLoading)
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: CommonColor
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () async {
                                                final picker = ImagePicker();

                                                try {
                                                  final pickedFile =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  if (pickedFile != null) {
                                                    // ✅ Crop the image before using it
                                                    final croppedFile =
                                                        await ImageCropper()
                                                            .cropImage(
                                                      sourcePath:
                                                          pickedFile.path,

                                                      // cropStyle: CropStyle.circle, // or CropStyle.rectangle
                                                      aspectRatio:
                                                          const CropAspectRatio(
                                                              ratioX: 1,
                                                              ratioY:
                                                                  1), // Square aspect
                                                      uiSettings: [
                                                        AndroidUiSettings(
                                                          toolbarTitle:
                                                              'Crop Image',
                                                          toolbarColor:
                                                              Colors.deepOrange,
                                                          toolbarWidgetColor:
                                                              Colors.white,
                                                          lockAspectRatio: true,
                                                        ),
                                                        IOSUiSettings(
                                                          title: 'Crop Image',
                                                          aspectRatioLockEnabled:
                                                              true,
                                                        ),
                                                      ],
                                                    );

                                                    if (croppedFile != null) {
                                                      await profileProvider
                                                          .updateProfileAvatar(
                                                              File(croppedFile
                                                                  .path));
                                                      await profileProvider
                                                          .loadProfileAvatar();

                                                      if (!context.mounted) {
                                                        return;
                                                      }

                                                      Utilities.showCommonSnackBar(
                                                          context,
                                                          "Avatar updated successfully!");
                                                    }
                                                  }
                                                } catch (e) {
                                                  if (!context.mounted) return;
                                                  Utilities.showCommonSnackBar(
                                                      context, "$e");
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(provider.profile.name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(provider.profile.email,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: CommonColor
                                                      .darkGreyColor)),
                                          if (provider.profile.emailVerified ==
                                              true)
                                            Padding(
                                              padding: EdgeInsets.only(left: 1),
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 12,
                                              ),
                                            )
                                        ],
                                      )
                                    ]));
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SizedBox(
                            height: screenHeight * 0.5,
                            child: ListView(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                      S.current.general,
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
                                          S.current.myProfile,
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
                                                      ShippingLocationScreen()));
                                        },
                                        leading: Icon(
                                          Icons.location_history_outlined,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.address,
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
                                          S.current.resetPassword,
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
                                      S.current.orders,
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
                                                      SettingsInvoiceScreen()));
                                        },
                                        leading: Icon(
                                          MingCute.inventory_line,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.invoices,
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
                                                      OrderScreen()));
                                        },
                                        leading: Icon(
                                          Icons.history,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.orderHistory,
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
                                      S.current.systemSettings,
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
                                      // ListTile(
                                      //   leading: Icon(
                                      //     Icons.notification_important_outlined,
                                      //     color: CommonColor.primaryColor,
                                      //   ),
                                      //   title: Text(
                                      //     S.current.pushNotification,
                                      //     style: TextStyle(
                                      //         color: CommonColor.darkGreyColor),
                                      //   ),
                                      //   trailing: Transform.scale(
                                      //     scale: 0.8,
                                      //     child: Switch(
                                      //         activeColor:
                                      //             CommonColor.primaryColor,
                                      //         inactiveThumbColor:
                                      //             CommonColor.mediumGreyColor,
                                      //         value: provider
                                      //             .notficationSwitchState,
                                      //         onChanged: (bool? value) async {
                                      //           if (value == true) {
                                      //             // Ask for push notification permission
                                      //             bool granted = await OneSignal
                                      //                     .Notifications
                                      //                 .requestPermission(true);
                                      //             if (granted) {
                                      //               provider
                                      //                   .switchPushNotification(
                                      //                       true);
                                      //               await updateNotificationSubscription(
                                      //                   true);
                                      //               await PushNotificationSharedPref
                                      //                   .setNotificationOptIn(
                                      //                       true);
                                      //             } else {
                                      //               if (context.mounted) {
                                      //                 Utilities.showCommonSnackBar(
                                      //                     context,
                                      //                     "Notification permission denied");
                                      //               }
                                      //             }
                                      //           } else {
                                      //             // User turned off the switch
                                      //             provider
                                      //                 .switchPushNotification(
                                      //                     false);
                                      //             await updateNotificationSubscription(
                                      //                 false);
                                      //             await PushNotificationSharedPref
                                      //                 .setNotificationOptIn(
                                      //                     false);
                                      //           }
                                      //         }

                                      //         // onChanged: (bool? value) async {
                                      //         //   provider.switchPushNotification();
                                      //         //   await updateNotificationSubscription(
                                      //         //       value!);
                                      //         //   await PushNotificationSharedPref
                                      //         //       .setNotificationOptIn(value);
                                      //         // },
                                      //         ),
                                      //   ),
                                      // ),
                                      Consumer<LocalizationProvider>(builder:
                                          (context, localizationProvider,
                                              child) {
                                        return ListTile(
                                            leading: Icon(
                                              Icons.language_outlined,
                                              color: CommonColor.primaryColor,
                                            ),
                                            title: Text(
                                              S.current.languages,
                                              style: TextStyle(
                                                  color: CommonColor
                                                      .darkGreyColor),
                                            ),
                                            trailing: IntrinsicWidth(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: Row(
                                                  children: [
                                                    Text("Eng"),
                                                    Transform.scale(
                                                      scale: 0.8,
                                                      child: Switch(
                                                        activeColor: CommonColor
                                                            .primaryColor,
                                                        inactiveThumbColor:
                                                            CommonColor
                                                                .mediumGreyColor,
                                                        value: localizationProvider
                                                                .locale
                                                                .languageCode ==
                                                            "ja",
                                                        onChanged: (bool
                                                            isJapanese) async {
                                                          String newLanguage =
                                                              isJapanese
                                                                  ? "ja"
                                                                  : "en"; // Toggle language
                                                          localizationProvider
                                                              .setLocale(Locale(
                                                                  newLanguage)); // Update language
                                                          //to handle api calling
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          String selectedLan =
                                                              prefs.getString(
                                                                      'language') ??
                                                                  'en';
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          final productProvider =
                                                              Provider.of<
                                                                      ProductProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          logger.log(
                                                              "selected language:${selectedLan.toString()}");
                                                          if (selectedLan
                                                                  .toString() ==
                                                              "ja") {
                                                            productProvider
                                                                .resetWidgetProducts();
                                                            productProvider
                                                                .resetProductCategoriesWithOutAll();
                                                            productProvider
                                                                .resetOfferProducts();
                                                            // productProvider
                                                            //     .resetAllProducts();
                                                            Future.wait([
                                                              productProvider
                                                                  .getWidgetProductinJapanese(
                                                                      ""),
                                                              productProvider
                                                                  .getProductCategoriesWithoutAllinJapanese(),
                                                              productProvider
                                                                  .getOfferProductinJapanese(
                                                                      ""),
                                                              // productProvider
                                                              //     .getAllProduct(
                                                              //         ""),
                                                            ]);
                                                            logger.log(
                                                                "ja api called");
                                                          } else {
                                                            productProvider
                                                                .resetWidgetProducts();
                                                            productProvider
                                                                .resetProductCategoriesWithOutAll();
                                                            productProvider
                                                                .resetOfferProducts();
                                                            // productProvider
                                                            //     .resetAllProducts();
                                                            Future.wait([
                                                              productProvider
                                                                  .getWidgetProduct(
                                                                      ""),
                                                              productProvider
                                                                  .getProductCategoriesWithoutAll(),

                                                              productProvider
                                                                  .getOfferProduct(
                                                                      ""),
                                                              // productProvider
                                                              //     .getAllProductinJapanese(
                                                              //         ""),
                                                            ]);
                                                            logger.log(
                                                                "en api called");
                                                          }
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
                                          S.current.logout,
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    backgroundColor:
                                                        Colors.white,
                                                    alignment: Alignment.center,
                                                    titlePadding:
                                                        EdgeInsets.only(
                                                      top: 12,
                                                      bottom: 10,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 12),
                                                    title: Text(
                                                      "Confirm to delete account?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      spacing: 10,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            "Are you sure you want to delete this account?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: CommonColor
                                                                    .darkGreyColor),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          spacing: 15,
                                                          children: [
                                                            SizedBox(
                                                              width: 122,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                              color: CommonColor.primaryColor,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Cancel",
                                                                        style: TextStyle(
                                                                            color:
                                                                                CommonColor.primaryColor),
                                                                      )),
                                                            ),
                                                            SizedBox(
                                                              width: 122,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8)),
                                                                        backgroundColor:
                                                                            CommonColor.primaryColor,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          final authProvider = Provider.of<AuthProvider>(
                                                                              context,
                                                                              listen: false);
                                                                          await authProvider
                                                                              .deleteAccount();
                                                                          await SharedPrefLoggedinState
                                                                              .clearLoginState();
                                                                          if (context
                                                                              .mounted) {
                                                                            Navigator.pushAndRemoveUntil(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                                                                (route) => false);
                                                                            Utilities.showCommonSnackBar(context,
                                                                                "Account deleted successfully",
                                                                                icon: Icons.check);
                                                                          }
                                                                        } catch (e) {
                                                                          if (context
                                                                              .mounted) {
                                                                            Utilities.showCommonSnackBar(context,
                                                                                "$e");
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Consumer<AuthProvider>(builder: (context,
                                                                          authProvider,
                                                                          child) {
                                                                        return authProvider.isDeleteAccountLoading ==
                                                                                true
                                                                            ? CircularProgressIndicator(
                                                                                color: Colors.white,
                                                                              )
                                                                            : Text(
                                                                                "Delete",
                                                                                style: TextStyle(color: Colors.white),
                                                                              );
                                                                      })),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              });
                                        },
                                        leading: Icon(
                                          Icons.delete_outline,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.deleteAccount,
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
                                      S.current.contactAndSupport,
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
                                                      ContactScreen()));
                                        },
                                        leading: Icon(
                                          Icons.contact_page_outlined,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.contact,
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
                                                      FaqScreen()));
                                        },
                                        leading: Icon(
                                          Icons.question_answer_outlined,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.faqs,
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
                                                      ReportIssueScreen()));
                                        },
                                        leading: Icon(
                                          Icons.report_problem_outlined,
                                          color: CommonColor.primaryColor,
                                        ),
                                        title: Text(
                                          S.current.reportIssues,
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
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

//function to build avatar
  Widget _buildAvatarImage(SettingsProvider profileProvider) {
    if (profileProvider.avatarBytes != null) {
      return Image.memory(
        profileProvider.avatarBytes!,
        fit: BoxFit.cover,
      );
    } else {
      return _buildDefaultAvatar();
    }
  }

//function build default avatar
  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.white,
      height: 100,
      width: 100,
      child: Icon(
        Icons.person_outline,
        size: 90,
      ),
    );
  }

  //Logical part
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
                  CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ),
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
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
