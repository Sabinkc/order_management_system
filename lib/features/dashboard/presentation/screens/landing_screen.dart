import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigationbar_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/cart_screen.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_screen.dart';
import 'package:order_management_system/features/settings/presentation/screens/screens/settings_screen.dart';
import 'package:order_management_system/features/order%20history/presentation/screens/order_history_screen.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(),
      CartScreen(),
      OrderHistoryScreen(),
      InvoiceScreen(),
      SettingsScreen(),
    ];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Consumer<BottomNavigationbarProvider>(
          builder: (context, provider, child) {
            return screens[provider.selectedIndex];
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationbarProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              height: 85,
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
                    color: CommonColor.darkGreyColor),
                unselectedItemColor: CommonColor.darkGreyColor,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  //  fontSize: 14,
                ),
                // Reduce font size for selected label
                items: [
                  BottomNavigationBarItem(
                    label: S.current.home,
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                      colorFilter: ColorFilter.mode(
                          provider.selectedIndex == 0
                              ? CommonColor.primaryColor
                              : CommonColor.darkGreyColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.current.cart,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 29,
                      color: provider.selectedIndex == 1
                          ? CommonColor.primaryColor
                          : CommonColor.darkGreyColor,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/order.svg",
                      colorFilter: ColorFilter.mode(
                          provider.selectedIndex == 2
                              ? CommonColor.primaryColor
                              : CommonColor.darkGreyColor,
                          BlendMode.srcIn),
                    ),
                    label: S.current.orders,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/invoice.svg",
                      colorFilter: ColorFilter.mode(
                          provider.selectedIndex == 3
                              ? CommonColor.primaryColor
                              : CommonColor.darkGreyColor,
                          BlendMode.srcIn),
                    ),
                    label: S.current.invoices,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/setting.svg",
                      colorFilter: ColorFilter.mode(
                          provider.selectedIndex == 4
                              ? CommonColor.primaryColor
                              : CommonColor.darkGreyColor,
                          BlendMode.srcIn),
                    ),
                    label: S.current.settings,
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
