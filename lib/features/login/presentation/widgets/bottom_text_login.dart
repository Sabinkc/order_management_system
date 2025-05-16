import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/login/presentation/screens/privacy_policy_screen.dart';
import 'package:order_management_system/features/login/presentation/screens/terms_of_conditions_screen.dart';

class BottomTextLogin extends StatelessWidget {
  const BottomTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By using this app, you agree to our ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen()));
              },
              child: Text(
                "Privacy Policy ",
                style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
              ),
            ),
            Text(
              "and ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Colors.black),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsOfConditionsScreen()));
              },
              child: Text(
                "Terms and",
                style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
              ),
            ),
          ],
        ),
        Center(
          child: GestureDetector(
               onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsOfConditionsScreen()));
              },
            child: Text(
              "Condition",
              style: TextStyle(fontSize: 9, color: CommonColor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
