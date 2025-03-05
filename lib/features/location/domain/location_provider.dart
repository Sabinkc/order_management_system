import 'package:flutter/material.dart';
import 'package:order_management_system/features/location/data/address_model.dart';
import 'dart:developer' as logger;

class LocationProvider extends ChangeNotifier {
//provider to switch address category
  String addressCategory = "home";
  switchAdressCategory(String category) {
    addressCategory = category;
    // logger.log(addressCategory);
    notifyListeners();
  }

  //provider to add address
  List<AddressModel> addresses = [];

  int selectedIndex = 0;

  void addAddress(
      {String firstName = "John",
      String lastName = "Doe",
      String phone = "xxxxxxxxxx",
      String email = "email@email.com",
      String state = "unknown",
      String city = "unknown",
      String street = "unknown",
      String landmark = "unknown",
      String category = "unknown"}) {
    addresses.add(AddressModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        state: state,
        city: city,
        street: street,
        landmark: landmark,
        category: category));
    notifyListeners();
    logger.log("addresses: $addresses");
  }

  void editAddress(int index,
      {String firstName = "John",
      String lastName = "Doe",
      String phone = "xxxxxxxxxx",
      String email = "email@email.com",
      String state = "unknown",
      String city = "unknown",
      String street = "unknown",
      String landmark = "unknown",
      String category = "unknown"}) {
    addresses[index] = AddressModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        state: state,
        city: city,
        street: street,
        landmark: landmark,
        category: category);
    notifyListeners();
    logger.log("address after edit: ${addresses[index]}");
  }

  void editCategory(int index, String category) {
    addresses[index].category = category;
    notifyListeners();
  }

  void selectAddress(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void deleteAddress(int index) {
    addresses.removeAt(index);
    if (selectedIndex == index) {
      selectedIndex = 0;
    }
    if (selectedIndex > index) {
      selectedIndex = selectedIndex - 1;
    }
    notifyListeners();
  }
}
