// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/common/common_textfield.dart';
// import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
// import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
// import 'package:provider/provider.dart';

// class TextfieldandloginbuttonWidgetLogin extends StatelessWidget {
//   const TextfieldandloginbuttonWidgetLogin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Email",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: screenHeight * 0.008,
//         ),
//         CommonTextfield(
//           hintText: "johndoe@gmail.com",
//           prefixIcon: Icons.email,
//         ),
//         SizedBox(height: screenHeight * 0.04),
//         Text(
//           "Password",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: screenHeight * 0.008,
//         ),
//         Consumer<LoginTextfieldProvider>(builder: (context, provider, child) {
//           return CommonTextfield(
//             isObscure: provider.isObscure,
//             onSuffixPressed: provider.switchObscure,
//             hintText: "••••••••",
//             prefixIcon: Icons.lock,
//             suffixIcon: provider.isObscure == true
//                 ? Icons.visibility_off
//                 : Icons.visibility,
//           );
//         }),
//         Align(
//           alignment: Alignment.centerRight,
//           child: TextButton(
//             onPressed: () {},
//             child: Text(
//               "Forget password?",
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: screenHeight * 0.03,
//         ),
//         SizedBox(
//           width: double.infinity,
//           height: screenHeight * 0.065,
//           child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   foregroundColor: Colors.white,
//                   backgroundColor: CommonColor.primaryColor),
//               onPressed: () {
//                 Navigator.push(context,
//                     CupertinoPageRoute(builder: (context) => LandingScreen()));
//               },
//               child: Text(
//                 "Login",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:provider/provider.dart';

class TextfieldandloginbuttonWidgetLogin extends StatelessWidget {
  const TextfieldandloginbuttonWidgetLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final logger = Logger();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        CommonTextfield(
          controller: emailController,
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
        ),
        SizedBox(height: screenHeight * 0.04),
        Text(
          "Password",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Consumer<LoginTextfieldProvider>(builder: (context, provider, child) {
          return CommonTextfield(
            controller: passwordController,
            isObscure: provider.isObscure,
            onSuffixPressed: provider.switchObscure,
            hintText: "••••••••",
            prefixIcon: Icons.lock,
            suffixIcon: provider.isObscure == true
                ? Icons.visibility_off
                : Icons.visibility,
          );
        }),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forget password?",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.white,
                      backgroundColor: CommonColor.primaryColor),
                  onPressed: () async {
                    bool successfulLogin = await provider.login(
                        emailController.text, passwordController.text);

                    if (successfulLogin) {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => LandingScreen()),
                        );
                      }
                    } else {
                      logger.i("Login Failed");
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text("Login Failed!"),
                          ),
                        );
                      }
                    }
                    logger.i("login pressed");
                  },
                  child: provider.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
            );
          },
        ),
      ],
    );
  }
}
