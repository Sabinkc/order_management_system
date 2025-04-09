import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/location/presentation/widgets/common_location_textform_field.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String gender = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      final settingProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await settingProvider.getProfile();
      fullnameController.text = settingProvider.profile.name;
      contactNoController.text = settingProvider.profile.phone;
      emailController.text = settingProvider.profile.email;
      addressController.text = settingProvider.profile.address;
      settingProvider.resetSelectedGender();
      // gender = settingProvider.profile.gender;
      // settingProvider.selectedGender = gender;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return KeyboardDismisser(
      child: Scaffold(
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
                text: "My Profile",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ])),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Consumer<SettingsProvider>(
              builder: (context, profileProvider, child) {
            return profileProvider.isGetProfileLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ))
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Full Name",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonLocationTextformField(
                              fillColor: Colors.white,
                              controller: fullnameController,
                              hintText: "Full Name"),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Contact No",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonLocationTextformField(
                              fillColor: Colors.white,
                              keyboardType: TextInputType.number,
                              controller: contactNoController,
                              hintText: "Contact No"),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonLocationTextformField(
                              fillColor: Colors.white,
                              controller: emailController,
                              hintText: "Email"),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          Consumer<SettingsProvider>(
                              builder: (context, settingsProvider, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    elevation: 2,
                                    value: settingsProvider.selectedGender,
                                    dropdownColor: Colors.white,
                                    items: [
                                      DropdownMenuItem(
                                          value: "N/A",
                                          child: Text("Gender not set")),
                                      DropdownMenuItem(
                                          value: "male", child: Text("Male")),
                                      DropdownMenuItem(
                                          value: "female",
                                          child: Text("Female")),
                                      DropdownMenuItem(
                                          value: "others",
                                          child: Text("Others")),
                                    ],
                                    onChanged: (value) {
                                      settingsProvider
                                          .switchSelectedGender(value!);
                                    }),
                              ),
                            );
                          }),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                          CommonLocationTextformField(
                              fillColor: Colors.white,
                              controller: addressController,
                              hintText: "Address"),
                          SizedBox(height: screenHeight * 0.03),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final settingsProvider =
                                      Provider.of<SettingsProvider>(context,
                                          listen: false);
                                  final email = emailController.text.trim();
                                  final fullName =
                                      fullnameController.text.trim();
                                  final contactNo =
                                      contactNoController.text.trim();
                                  final gender =
                                      settingsProvider.selectedGender;
                                  final address = addressController.text.trim();

                                  if (email.isEmpty || fullName.isEmpty) {
                                    Utilities.showCommonSnackBar(
                                        color: Colors.red,
                                        context,
                                        "Fullname and email cannot be empty!");
                                  } else {
                                    await profileProvider.updateProfile(
                                        context,
                                        fullName,
                                        email,
                                        contactNo,
                                        gender,
                                        address);
                                
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Utilities.showCommonSnackBar(context,
                                          "Profile Updated Successully!");
                                    }
                                        await profileProvider.getProfile();
                                  }
                                } catch (e) {
                                  if (!context.mounted) {
                                    return;
                                  }
                                  Utilities.showCommonSnackBar(context, "$e");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: CommonColor.primaryColor),
                              child:
                                  profileProvider.isUpdateProfileLoading == true
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Update",
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
          })),
    );
  }
}
