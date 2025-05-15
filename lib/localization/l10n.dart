// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_management_system/localization/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Localization`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Hello World`
  String get myOrders {
    return Intl.message(
      'My Order',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `This is example of localization in flutter`
  String get invoices {
    return Intl.message(
      'Invoices',
      name: 'invoices',
      desc: '',
      args: [],
    );
  }

  /// `This world is so beautiful`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  String get systemSettings {
    return Intl.message(
      'System Settings',
      name: 'systemSettings',
      desc: '',
      args: [],
    );
  }

  String get pushNotification {
    return Intl.message(
      'Push Notification',
      name: 'pushNotification',
      desc: '',
      args: [],
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  String get contactAndSupport {
    return Intl.message(
      'Contact and Support',
      name: 'contactAndSupport',
      desc: '',
      args: [],
    );
  }

  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  String get faqs {
    return Intl.message(
      'FAQs',
      name: 'faqs',
      desc: '',
      args: [],
    );
  }

  String get reportIssues {
    return Intl.message(
      'Report Issues',
      name: 'reportIssues',
      desc: '',
      args: [],
    );
  }

  String get verifyEmail {
    return Intl.message(
      'Please verify your email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  String get whatTo {
    return Intl.message(
      'What would you like to',
      name: 'whatTo',
      desc: '',
      args: [],
    );
  }

  String get buyToday {
    return Intl.message(
      ' buy today?',
      name: 'buyToday',
      desc: '',
      args: [],
    );
  }

  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  String get invoiceDetails {
    return Intl.message(
      'Invoice Details',
      name: 'invoiceDetails',
      desc: '',
      args: [],
    );
  }

  String get totalQuantity {
    return Intl.message(
      'Total Quantity',
      name: 'totalQuantity',
      desc: '',
      args: [],
    );
  }

  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  String get chooseAddress {
    return Intl.message(
      'Choose Delivery Address',
      name: 'chooseAddress',
      desc: '',
      args: [],
    );
  }

  String get confirmAddress {
    return Intl.message(
      'Confirm Address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  String get checkout {
    return Intl.message(
      'Check Out',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  String get productCatalog {
    return Intl.message(
      'Product Catalog',
      name: 'productCatalog',
      desc: '',
      args: [],
    );
  }

  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  String get allOffers {
    return Intl.message(
      'All Offers',
      name: 'allOffers',
      desc: '',
      args: [],
    );
  }

  String get addDeliveryAddress {
    return Intl.message(
      'Add Delivery Address',
      name: 'addDeliveryAddress',
      desc: '',
      args: [],
    );
  }

  String get yourContactDetails {
    return Intl.message(
      'Your Contact Details',
      name: 'yourContactDetails',
      desc: '',
      args: [],
    );
  }

  String get yourDeliveryAddress {
    return Intl.message(
      'Your Delivery Address',
      name: 'yourDeliveryAddress',
      desc: '',
      args: [],
    );
  }

  String get addDetails {
    return Intl.message(
      'Add Details',
      name: 'addDetails',
      desc: '',
      args: [],
    );
  }

  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  String get viewInvoice {
    return Intl.message(
      'View Invoice',
      name: 'viewInvoice',
      desc: '',
      args: [],
    );
  }

  String get resetFilter {
    return Intl.message(
      'Reset Filter',
      name: 'resetFilter',
      desc: '',
      args: [],
    );
  }

  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  String get addShippingAddress {
    return Intl.message(
      'Add Shipping Address',
      name: 'addShippingAddress',
      desc: '',
      args: [],
    );
  }

  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  String get editShippingAddress {
    return Intl.message(
      'Edit Shipping Address',
      name: 'editShippingAddress',
      desc: '',
      args: [],
    );
  }

  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  String get update {
  return Intl.message(
    'Update',
    name: 'update',
    desc: '',
    args: [],
  );
}
String get orderDetails {
  return Intl.message(
    'Order Details',
    name: 'orderDetails',
    desc: '',
    args: [],
  );
}

String get contactUs {
  return Intl.message(
    'Contact Us',
    name: 'contactUs',
    desc: '',
    args: [],
  );
}

String get sendReport {
  return Intl.message(
    'Send Report',
    name: 'sendReport',
    desc: '',
    args: [],
  );
}
String get orderStatus {
  return Intl.message(
    'Order Status',
    name: 'orderStatus',
    desc: '',
    args: [],
  );
}

String get searchInvoice {
  return Intl.message(
    'Search Invoice',
    name: 'searchInvoice',
    desc: '',
    args: [],
  );
}

String get searchOrders {
  return Intl.message(
    'Search Orders',
    name: 'searchOrders',
    desc: '',
    args: [],
  );
}
String get orderDate {
  return Intl.message(
    'Order Date',
    name: 'orderDate',
    desc: '',
    args: [],
  );
}
String get deleteAccount {
  return Intl.message(
    'Delete Account',
    name: 'deleteAccount',
    desc: '',
    args: [],
  );
}


}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
