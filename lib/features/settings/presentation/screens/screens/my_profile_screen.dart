import 'package:flutter/material.dart';
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
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // @override
  // void initState() {
  //   fullnameController.text = "John Doe";
  //   contactNoController.text = "9876543210";
  //   emailController.text = "johndoe@gmail.com";

  //   super.initState();
  // }

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
      genderController.text = settingProvider.profile.gender;
      addressController.text = settingProvider.profile.address;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                size: 20,
              )),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "My Profile",
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
          child: Consumer<SettingsProvider>(
              builder: (context, profileProvider, child) {
            return profileProvider.isGetProfileLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ))
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            controller: emailController, hintText: "Email"),
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
                        CommonLocationTextformField(
                            controller: genderController, hintText: "Gender"),
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
                            controller: addressController, hintText: "Address"),
                        SizedBox(height: screenHeight * 0.03),
                        SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final email = emailController.text.trim();
                                final fullName = fullnameController.text.trim();
                                final contactNo =
                                    contactNoController.text.trim();
                                final gender = genderController.text.trim();
                                final address = addressController.text.trim();

                                if (email.isEmpty ||
                                    fullName.isEmpty ||
                                    contactNo.isEmpty ||
                                    gender.isEmpty ||
                                    address.isEmpty) {
                                  Utilities.showCommonSnackBar(
                                      color: Colors.red,
                                      context,
                                      "Fields cannot be empty!");
                                } else {
                                  await profileProvider.updateProfile(
                                      context,
                                      fullName,
                                      email,
                                      contactNo,
                                      gender,
                                      address);
                                  // Refresh data after update
                                  await profileProvider.getProfile();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    Utilities.showCommonSnackBar(context,
                                        "Profile Updated Successully!");
                                  }
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
                  );
          }),
        ));
  }
}
