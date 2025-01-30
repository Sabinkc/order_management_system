import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigationbar_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:order_management_system/features/profile/presentation/screens/profile_screen.dart';
import 'package:order_management_system/features/order%20history/presentation/screens/order_history_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(),
      OrderHistoryScreen(),
      ProfileScreen(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(body: Consumer<BottomNavigationbarProvider>(
        builder: (context, provider, child) {
          return screens[provider.selectedIndex];
        },
      ), bottomNavigationBar: Consumer<BottomNavigationbarProvider>(
          builder: (context, provider, child) {
        return BottomNavigationBar(
            onTap: (index) {
              Provider.of<BottomNavigationbarProvider>(context, listen: false)
                  .updateSelectedIndex(index);
            },
            currentIndex: provider.selectedIndex,
            selectedItemColor: CommonColor.primaryColor,
            selectedIconTheme: IconThemeData(color: CommonColor.primaryColor),
            items: [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]);
      })),
    );
  }
}
