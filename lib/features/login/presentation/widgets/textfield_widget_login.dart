// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_textfield.dart';
// import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
// import 'package:provider/provider.dart';

// class TextfieldWidgetLogin extends StatelessWidget {
//   const TextfieldWidgetLogin({super.key});

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
//       ],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:provider/provider.dart';

class TextfieldWidgetLogin extends StatefulWidget {
  const TextfieldWidgetLogin({super.key});

  @override
  State<TextfieldWidgetLogin> createState() => _TextfieldWidgetLoginState();
}

class _TextfieldWidgetLoginState extends State<TextfieldWidgetLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _deviceName = "Fetching device name...";

  @override
  void initState() {
    super.initState();
    fetchDeviceName();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> fetchDeviceName() async {
    final deviceName = await DeviceInfoHelper.getDeviceName();
    setState(() {
      _deviceName = deviceName;
    });
  }

  Future<int> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return 1;
    }

    final errorMessage = await authProvider.login(
      email: email,
      password: password,
      deviceName: _deviceName,
    );

    if (errorMessage == null) {
      // Login successful
      return 0;
    } else {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $errorMessage")),
      );
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context).isLoading;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.008),
        CommonTextfield(
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
          controller: emailController,
        ),
        SizedBox(height: screenHeight * 0.04),
        const Text(
          "Password",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.008),
        Consumer<LoginTextfieldProvider>(
          builder: (context, provider, child) {
            return CommonTextfield(
              controller: passwordController,
              isObscure: provider.isObscure,
              onSuffixPressed: provider.switchObscure,
              hintText: "••••••••",
              prefixIcon: Icons.lock,
              suffixIcon:
                  provider.isObscure ? Icons.visibility_off : Icons.visibility,
            );
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Add Forgot Password Logic
            },
            child: const Text(
              "Forgot password?",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: CommonColor.primaryColor,
                  ),
                  onPressed: () async {
                    final result = await _login();
                    if (result == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LandingScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ],
    );
  }
}
