import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class CommonTextfield extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final void Function()? onSuffixPressed;
  final bool isObscure;
  final bool isEnabled;

  const CommonTextfield({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onSuffixPressed,
    this.isObscure = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      obscureText: isObscure,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: CommonColor.darkGreyColor,
        ),
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
          color: CommonColor.primaryColor,
        ),
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(
            suffixIcon,
            size: 20,
            color: CommonColor.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Colors.transparent), // Transparent border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: CommonColor.primaryColor,
              width: 2), // Focused border color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Colors.red, width: 2), // Error border color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: Colors.red, width: 2), // Focused error border color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey), // Disabled border color
        ),
      ),
    );
  }
}
