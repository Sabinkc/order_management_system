import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_textfield.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:provider/provider.dart';

class TextfieldWidgetLogin extends StatelessWidget {
  const TextfieldWidgetLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
          hintText: "johndoe@gmail.com",
          prefixIcon: Icons.email,
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          "Password",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Consumer<LoginTextfieldProvider>(builder: (context, provider, child) {
          return CommonTextfield(
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
      ],
    );
  }
}
