import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/features/signup/presentation/screens/signup_screen.dart';

class TopTextLogin extends StatelessWidget {
  const TopTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
