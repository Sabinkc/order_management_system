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
      {String fullName = "John",
      String phone = "xxxxxxxxxx",
      String email = "email@email.com",
      String state = "unknown",
      String city = "unknown",
      String street = "unknown",
      String landmark = "unknown",
      }) {
    addresses.add(AddressModel(
        fullName: fullName,
        phone: phone,
        email: email,
        state: state,
        city: city,
        street: street,
        landmark: landmark,
        ));
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
      }) {
    addresses[index] = AddressModel(
        fullName: firstName,
        phone: phone,
        email: email,
        state: state,
        city: city,
        street: street,
        landmark: landmark,
        );
    notifyListeners();
    logger.log("address after edit: ${addresses[index]}");
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

  String longitude = "";
  String latitude = "";

  void addLatitudeLongitue(String lat, String long) {
    longitude = long;
    latitude = lat;
    notifyListeners();
  }
}
