// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';

// import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';

// class LoginButton extends StatelessWidget {
//   const LoginButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return SizedBox(
//       width: double.infinity,
//       height: screenHeight * 0.065,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//               foregroundColor: Colors.white,
//               backgroundColor: CommonColor.primaryColor),
//           onPressed: () {
//             Navigator.push(context,
//                 CupertinoPageRoute(builder: (context) => LandingScreen()));
//           },
//           child: Text(
//             "Login",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )),
//     );
//   }
// }
