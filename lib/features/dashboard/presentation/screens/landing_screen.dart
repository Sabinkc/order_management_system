import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigationbar_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_screen.dart';
import 'package:order_management_system/features/profile/presentation/screens/settings_screen.dart';
import 'package:order_management_system/features/order%20history/presentation/screens/order_history_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(),
      OrderHistoryScreen(),
      InvoiceScreen(),
      SettingsScreen(),
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Consumer<BottomNavigationbarProvider>(
          builder: (context, provider, child) {
            return screens[provider.selectedIndex];
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationbarProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              height: 80,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,

                backgroundColor: Colors.grey[100],
                onTap: (index) {
                  Provider.of<BottomNavigationbarProvider>(context,
                          listen: false)
                      .updateSelectedIndex(index);
                },
                currentIndex: provider.selectedIndex,
                selectedItemColor: CommonColor.primaryColor,
                selectedIconTheme:
                    IconThemeData(color: CommonColor.primaryColor),
                unselectedIconTheme:
                    IconThemeData(color: CommonColor.mediumGreyColor),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: CommonColor.mediumGreyColor),
                unselectedItemColor: CommonColor.mediumGreyColor,
                showUnselectedLabels: true,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                // Reduce font size for selected label
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(BoxIcons.bx_home),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(BoxIcons.bx_cart),
                    label: "Orders",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Bootstrap.card_list),
                    label: "Invoices",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: "Settings",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
