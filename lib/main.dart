import 'package:flutter/material.dart';
import 'package:order_management_system/features/login/presentation/login_screen.dart';

void main(List<String> args) {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

