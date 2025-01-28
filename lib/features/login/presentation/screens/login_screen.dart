import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/login/presentation/widgets/bottom_text_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/divider_text_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/google_button_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/login_button.dart';
import 'package:order_management_system/features/login/presentation/widgets/textfield_widget_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/top_text_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        top: screenHeight * 0.27,
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
                            SizedBox(height: screenHeight * 0.12),
                            const TopTextLogin(),
                            SizedBox(height: screenHeight * 0.1),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextfieldWidgetLogin(),
                                  SizedBox(height: screenHeight * 0.03),
                                  const LoginButton(),
                                  SizedBox(height: screenHeight * 0.05),
                                  const DividerTextLogin(),
                                  SizedBox(height: screenHeight * 0.05),
                                  const GoogleButtonLogin(),
                                  SizedBox(height: screenHeight * 0.045),
                                  const BottomTextLogin(),
                                ],
                              ),
                            ),
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




// import 'package:flutter/material.dart';
// import 'package:order_management_system/features/login/domain/auth_provider.dart';
// import 'package:order_management_system/features/login/domain/device_info_helper.dart';
// import 'package:provider/provider.dart';


// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _deviceName = "Fetching device name...";

//   @override
//   void initState() {
//     super.initState();
//     _fetchDeviceName();
//   }

//   Future<void> _fetchDeviceName() async {
//     final deviceName = await DeviceInfoHelper.getDeviceName();
//     setState(() {
//       _deviceName = deviceName;
//     });
//   }

//   Future<void> _login() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill all fields")),
//       );
//       return;
//     }

//     final errorMessage = await authProvider.login(
//       email: email,
//       password: password,
//       deviceName: _deviceName,
//     );

//     if (errorMessage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login Successful!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $errorMessage")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = Provider.of<AuthProvider>(context).isLoading;

//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: "Email"),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             SizedBox(height: 16),
//             Text("Device: $_deviceName"),
//             SizedBox(height: 32),
//             isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : ElevatedButton(
//                     onPressed: _login,
//                     child: Text("Login"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
