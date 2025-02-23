import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';


class ProductProvider extends ChangeNotifier {
  final _service = ProductApiSevice();
  bool isCategoryLoading = false;
  List productCategory = [];


  Future<void> getAllProductCategories() async {
    isCategoryLoading = true;
    notifyListeners();
    final response = await _service.getProductCategories();
    productCategory = response;
    isCategoryLoading = false;
    notifyListeners();
  }

  bool isCategoryProductLoading = false;
  List categoryProducts = [];

  Future<void> getCategoryProducts(int c) async{
    isCategoryProductLoading = true;
    notifyListeners();
    final response = await _service.getProductsByCategory(c);
    categoryProducts = response;
    notifyListeners();
  }
}