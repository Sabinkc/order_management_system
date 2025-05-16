import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/login/presentation/screens/terms_of_conditions_screen.dart';
import 'package:order_management_system/features/signup/domain/checkbox_provider.dart';
import 'package:provider/provider.dart';

class CheckboxWidgetSignup extends StatelessWidget {
  const CheckboxWidgetSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<CheckboxProvider>(
          builder: (context, provider, child) {
            return Checkbox(
                activeColor: CommonColor.primaryColor,
                value: provider.isSelected,
                onChanged: (value) {
                  provider.switchSelection();
                });
          },
        ),
        Text(
          "I agree to the ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsOfConditionsScreen()));
          },
          child: Text(
            "Terms & Conditions",
            style: TextStyle(fontSize: 12, color: CommonColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
