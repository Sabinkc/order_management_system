// import 'package:flutter/material.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';

// import 'package:order_management_system/features/signup/presentation/widgets/checkbox_widget_signup.dart';
// import 'package:order_management_system/features/signup/presentation/widgets/signup_button.dart';
// import 'package:order_management_system/features/signup/presentation/widgets/textfield_widget_signup.dart';
// import 'package:order_management_system/features/signup/presentation/widgets/top_text_signup.dart';

// class SignupScreen extends StatelessWidget {
//   const SignupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return KeyboardDismisser(
//       child: Scaffold(
//         backgroundColor: CommonColor.primaryColor,
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: screenHeight *
//                     0.23, // Start the green background below the "Login" text
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: CommonColor
//                         .commonGreyColor, // Replace with your desired green color
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(50),
//                       topRight: Radius.circular(50),
//                     ),
//                   ),
//                 ),
//               ),
//               // Main content
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: screenHeight * 0.06,
//                     ),
//                     TopTextSignup(),
//                     SizedBox(height: screenHeight * 0.1),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextfieldWidgetSignup(),
//                           SizedBox(
//                             height: screenHeight * 0.01,
//                           ),
//                           CheckboxWidgetSignup(),
//                           SizedBox(
//                             height: screenHeight * 0.01,
//                           ),
//                           SignupButton(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.06),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/signup/presentation/widgets/checkbox_widget_signup.dart';
import 'package:order_management_system/features/signup/presentation/widgets/signup_button.dart';
import 'package:order_management_system/features/signup/presentation/widgets/textfield_widget_signup.dart';
import 'package:order_management_system/features/signup/presentation/widgets/top_text_signup.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CommonColor.primaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      // Green background container
                      Positioned(
                        top: screenHeight * 0.23,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: double
                              .infinity, // Ensures it covers the remaining area
                          decoration: BoxDecoration(
                            color: CommonColor.commonGreyColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      // Main content
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.06),
                            const TopTextSignup(),
                            SizedBox(height: screenHeight * 0.1),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextfieldWidgetSignup(),
                                  SizedBox(height: screenHeight * 0.015),
                                  const CheckboxWidgetSignup(),
                                  SizedBox(height: screenHeight * 0.015),
                                  const SignupButton(),
                                ],
                              ),
                            ),
                            // SizedBox(height: screenHeight * 0.04),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
