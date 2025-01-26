import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:order_management_system/features/signup/domain/checkbox_provider.dart';
import 'package:order_management_system/features/signup/domain/signup_textfield_provider.dart';
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
        ChangeNotifierProvider<TabBarProvider>(create: (_) => TabBarProvider()),
        ChangeNotifierProvider<CheckboxProvider>(
            create: (_) => CheckboxProvider()),
        ChangeNotifierProvider<LoginTextfieldProvider>(
            create: (_) => LoginTextfieldProvider()),
        ChangeNotifierProvider<SignupTextfieldProvider>(
            create: (_) => SignupTextfieldProvider()),
            ChangeNotifierProvider<CartQuantityProvider>(
            create: (_) => CartQuantityProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
