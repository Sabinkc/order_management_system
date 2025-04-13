import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/presentation/widgets/bottom_text_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/textfieldandloginbutton_widget_login.dart';
import 'package:order_management_system/features/login/presentation/widgets/top_text_login.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
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
                                  TextfieldandloginbuttonWidgetLogin(),
                                  SizedBox(height: screenHeight * 0.05),
                                  // const DividerTextLogin(),
                                  // SizedBox(height: screenHeight * 0.05),
                                  // const GoogleButtonLogin(),
                                  SizedBox(
                                    height: screenHeight * 0.13,
                                  ),
                                  SizedBox(height: screenHeight * 0.045),
                                  const BottomTextLogin(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (authProvider.isLoginWithGoogleLoading)
                        Positioned.fill(
                          top: screenHeight * 0.3,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(
                              color: Colors.grey[400],
                            ),
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
