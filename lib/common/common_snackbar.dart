import 'package:flutter/material.dart';

class CommonSnackbar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  const CommonSnackbar(
      {super.key, required this.title, this.backgroundColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: Duration(seconds: 1),
      content: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
