import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigation_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/dashboard_screen.dart';
import 'package:order_management_system/features/login/presentation/login_screen.dart';
import 'package:order_management_system/features/register/presentation/register_screen.dart';
import 'package:order_management_system/test_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
   providers: [
    ChangeNotifierProvider(create: (_)=> BottomNavigationProvider()),
   ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
