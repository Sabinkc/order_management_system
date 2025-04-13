import 'package:flutter/material.dart';
import 'package:order_management_system/features/location/data/address_model.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/features/location/data/location_api_service.dart';

class LocationProvider extends ChangeNotifier {
//provider to switch address category
  // String addressCategory = "home";
  // switchAdressCategory(String category) {
  //   addressCategory = category;
  //   // logger.log(addressCategory);
  //   notifyListeners();
  // }

  // //provider to add address
  // List<AddressModel> addresses = [];

  int selectedIndex = 0;

  // void addAddress({
  //   String fullName = "John",
  //   String phone = "xxxxxxxxxx",
  //   String email = "email@email.com",
  //   String state = "unknown",
  //   String city = "unknown",
  //   String street = "unknown",
  //   String landmark = "unknown",
  // }) {
  //   addresses.add(AddressModel(
  //     id: 1,
  //     fullName: fullName,
  //     phone: phone,
  //     email: email,
  //     state: state,
  //     city: city,
  //     area: street,
  //     landmark: landmark,
  //   ));
  //   notifyListeners();
  //   logger.log("addresses: $addresses");
  // }

  // void editAddress(
  //   int index, {
  //   String firstName = "John",
  //   String lastName = "Doe",
  //   String phone = "xxxxxxxxxx",
  //   String email = "email@email.com",
  //   String state = "unknown",
  //   String city = "unknown",
  //   String street = "unknown",
  //   String landmark = "unknown",
  // }) {
  //   addresses[index] = AddressModel(
  //     id: 1,
  //     fullName: firstName,
  //     phone: phone,
  //     email: email,
  //     state: state,
  //     city: city,
  //     area: street,
  //     landmark: landmark,
  //   );
  //   notifyListeners();
  //   logger.log("address after edit: ${addresses[index]}");
  // }

  void selectAddress(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // void deleteAddress(int index) {
  //   addresses.removeAt(index);
  //   if (selectedIndex == index) {
  //     selectedIndex = 0;
  //   }
  //   if (selectedIndex > index) {
  //     selectedIndex = selectedIndex - 1;
  //   }
  //   notifyListeners();
  // }

  String longitude = "";
  String latitude = "";

  void addLatitudeLongitue(String lat, String long) {
    longitude = long;
    latitude = lat;
    notifyListeners();
  }

  //provider create shipping location with api
  final LocationApiService locationApiService = LocationApiService();
  bool isCreateShippingLocationLoading = false;
  Future createShippingLocation(
      String receiverName,
      String receiverPhone,
      String receiverEmail,
      double lat,
      double long,
      String prefecture,
      String city,
      String area,
      String? landmark) async {
    isCreateShippingLocationLoading = true;
    notifyListeners();
    try {
      final response = await locationApiService.createShippingLocation(
          receiverName,
          receiverPhone,
          receiverEmail,
          lat,
          long,
          prefecture,
          city,
          area,
          landmark);
      notifyListeners();
      return response;
    } catch (e) {
      logger.log("$e");
      throw "$e";
    } finally {
      isCreateShippingLocationLoading = false;
      notifyListeners();
    }
  }

  //provider to get shipping locations with API
  bool isGeAllLocationLoading = false;
  List<AddressModel> locations = [];
  Future getAllLocation() async {
    isGeAllLocationLoading = true;
    notifyListeners();
    try {
      final response = await locationApiService.getAllLocation();
      locations = response;
    } catch (e) {
      throw "$e";
    } finally {
      isGeAllLocationLoading = false;
      notifyListeners();
      logger.log("locations: $locations");
    }
  }

  //provder to delete locations
  bool isDeleteLocationLoading = false;
  Future deleteLocation(int locationId) async {
    isDeleteLocationLoading = true;
    notifyListeners();
    try {
      await locationApiService.deleteLocation(locationId);
      locations.removeWhere((location) => location.id == locationId);
      notifyListeners();
      logger.log("locations: $locations");
    } catch (e) {
      logger.log(e.toString());
      throw "$e";
    } finally {
      isDeleteLocationLoading = false;
      notifyListeners();
    }
  }

  // provider to updateLocation
  bool isUpdateLocationLoading = false;
  Future updateLocation(
      int locationId,
      String name,
      String phone,
      String email,
      double lat,
      double long,
      String prefecture,
      String city,
      String area,
      String landmark) async {
    isUpdateLocationLoading = true;
    notifyListeners();
    try {
      await locationApiService.updateShippingLocation(
          locationId: locationId,
          receiverEmail: email,
          receiverName: name,
          receiverPhone: phone,
          lat: lat,
          long: long,
          prefecture: prefecture,
          city: city,
          area: area,
          landmark: landmark);
      notifyListeners();
      logger.log("locations: $locations");
    } catch (e) {
      logger.log(e.toString());
      throw "$e";
    } finally {
      isUpdateLocationLoading = false;
      notifyListeners();
    }
  }
}
