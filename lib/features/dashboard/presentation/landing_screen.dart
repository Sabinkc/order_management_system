import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigation_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/dashboard_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(),
      Center(child: Text("Message screen")),
      Center(child: Text("ShoppingCart Screen")),
    ];

    return Scaffold(body: Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) {
        return screens[provider.CurrentIndex];
      },
    ), bottomNavigationBar: Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) {
        return BottomNavigationBar(
            selectedItemColor: CommonColor.primaryColor,
            // selectedFontSize: 16,
            // selectedIconTheme: IconThemeData(
            //   size: 30,
            // ),
            currentIndex: provider.CurrentIndex,
            onTap: (index) {
              provider.updateIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home,
                  )),
              BottomNavigationBarItem(
                  label: "Messages",
                  icon: Icon(
                    Icons.message,
                  )),
              BottomNavigationBarItem(
                  label: "Cart",
                  icon: Icon(
                    Icons.shopping_cart,
                  ))
            ]);
      },
    ));
  }
}
