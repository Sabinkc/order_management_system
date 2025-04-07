import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "FAQS",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColor.primaryColor,
              size: 20,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Text(
        "Faqs Screen",
        style: TextStyle(color: Colors.grey, fontSize: 25),
      )),
    );
  }
}
