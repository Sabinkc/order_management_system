import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/signup/presentation/widgets/textfield_widget_signup.dart';
import 'package:order_management_system/features/signup/presentation/widgets/top_text_signup.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CommonColor.primaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
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
                                    TextfieldWidgetSignup(),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
