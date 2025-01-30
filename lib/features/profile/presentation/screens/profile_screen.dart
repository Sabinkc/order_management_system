import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/profile/domain/profile_data_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Pro",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "file",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {},
          ),
          actions: [
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body:
            Consumer<ProfileDataProvider>(builder: (context, provider, child) {
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
                ListTile(
                  leading: Icon(Icons.card_travel_outlined),
                  title: Text(
                    "My cards",
                    style: TextStyle(),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(
                  height: 0,
                  color: CommonColor.commonGreyColor,
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text(
                    "Settings",
                    style: TextStyle(),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(
                  height: 0,
                  color: CommonColor.commonGreyColor,
                ),
                ListTile(
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
        }));
  }
}
