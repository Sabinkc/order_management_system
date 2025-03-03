import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/connectivity/connectivty_provider.dart';
import 'package:order_management_system/features/connectivity/dependency_injection.dart';
import 'package:order_management_system/features/dashboard/domain/bottom_navigationbar_provider.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/domain/login_textfield_provider.dart';
import 'package:order_management_system/features/login/presentation/screens/login_screen.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:order_management_system/features/order%20history/domain/switch_order_screen_provider.dart';
import 'package:order_management_system/features/profile/domain/profile_data_provider.dart';
import 'package:order_management_system/features/signup/domain/checkbox_provider.dart';
import 'package:order_management_system/features/signup/domain/signup_textfield_provider.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:order_management_system/localization/localization_provider.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedin = await SharedPrefLoggedinState.getLoginState();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationProvider>(
            create: (_) => LocalizationProvider()..init()),
        ChangeNotifierProvider<TabBarProvider>(create: (_) => TabBarProvider()),
        ChangeNotifierProvider<CheckboxProvider>(
            create: (_) => CheckboxProvider()),
        ChangeNotifierProvider<LoginTextfieldProvider>(
            create: (_) => LoginTextfieldProvider()),
        ChangeNotifierProvider<SignupTextfieldProvider>(
            create: (_) => SignupTextfieldProvider()),
        ChangeNotifierProvider<CartQuantityProvider>(
            create: (_) => CartQuantityProvider()),
        ChangeNotifierProvider<SignupTextfieldProvider>(
            create: (_) => SignupTextfieldProvider()),
        ChangeNotifierProvider<BottomNavigationbarProvider>(
            create: (_) => BottomNavigationbarProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ProfileDataProvider>(
            create: (_) => ProfileDataProvider()),
        ChangeNotifierProvider<OrderHistoryProvider>(
            create: (_) => OrderHistoryProvider()),
        ChangeNotifierProvider<ConnectivityProvider>(
            create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider<SwitchOrderScreenProvider>(
            create: (_) => SwitchOrderScreenProvider()),
               ChangeNotifierProvider<InvoiceScreenProvider>(
            create: (_) => InvoiceScreenProvider()),
            ChangeNotifierProvider<SimpleUiProvider>(create: (_)=>SimpleUiProvider()),
              ChangeNotifierProvider<ProductProvider>(create: (_)=>ProductProvider()),
      ],
      child: MyApplication(
        isLoggedin: isLoggedin,
      )));

  DependencyInjection.init();
}

class MyApplication extends StatelessWidget {
  final bool isLoggedin;
  const MyApplication({super.key, required this.isLoggedin});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
      return GetMaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: localizationProvider.locale,
        debugShowCheckedModeBanner: false,
        home: isLoggedin ? LandingScreen() : LoginScreen(),
      );
    });
  }
}
