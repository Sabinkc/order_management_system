import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:order_management_system/features/login/presentation/login_screen.dart';
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
        Provider<TabBarProvider>(create: (_) => TabBarProvider()),
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
