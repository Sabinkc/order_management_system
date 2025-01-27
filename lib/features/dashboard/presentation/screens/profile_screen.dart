import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
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
      body: Center(child: Text("Profile")),
    );
  }
}
