import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'dart:developer' as logger;

import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  final _service = ProductApiSevice();

  // Provider to get all categories
  bool isCategoryLoading = false;
  List productCategory = [];

  Future<void> getAllProductCategories() async {
    isCategoryLoading = true;
    notifyListeners();
    final response = await _service.getProductCategories();
    // Add the "All" category at the beginning of the list
    productCategory = [
      ProductCategory(id: 0, name: "All", productsCount: product.length),
      ...response
    ];
    isCategoryLoading = false;
    notifyListeners();
  }

//provider to fecth proudct category without all
  List productCategoryWithoutAll = [];
  bool isCategoryWithoutallLoading = false;
  Future<void> getProductCategoriesWithoutAll() async {
    isCategoryWithoutallLoading = true;
    notifyListeners();
    final response = await _service.getProductCategories();
    productCategoryWithoutAll = response;
    isCategoryWithoutallLoading = false;
    // logger.log(productCategoryWithoutAll.toString());
    notifyListeners();
  }

  // Provider to fetch all products
  bool isProductLoading = false;
  List product = [];

  Future<void> getAllProduct() async {
    isProductLoading = true;
    notifyListeners();
    final response = await _service.getAllProducts();
    product = response;
    notifyListeners();
    logger.log("product in provider: $product");
    isProductLoading = false;
    notifyListeners();
  }

  // Provider to get product category-wise
  bool isCategoryProductLoading = false;
  List categoryProducts = [];

  Future<void> getCategoryProducts(int categoryId) async {
    isCategoryProductLoading = true;
    notifyListeners();
    if (categoryId == 0) {
      final response = await _service.getAllProducts();
      product = response;
      // If "All" category is selected, use the full product list
      categoryProducts = List.from(product);
      notifyListeners();
    } else {
      // Otherwise, fetch products for the specific category
      final response = await _service.getProductsByCategory(categoryId);
      categoryProducts = response;
    }
    // Update filtered products
    filteredCategoryProducts = List.from(categoryProducts);
    isCategoryProductLoading = false;
    notifyListeners();
  }

  // Provider to search products
  List filteredCategoryProducts = [];

  // Search for products based on a keyword
  void searchProducts(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    final query = tabBarProvider.searchKeyword;

    if (query.isEmpty) {
      // If the search query is empty, show all products
      filteredCategoryProducts = List.from(categoryProducts);
    } else {
      // Filter products based on the search keyword
      filteredCategoryProducts = categoryProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // //provider to create orders
  // bool isCreateOrderLoading = false;
  // Future<Map<String, dynamic>> createOrder(
  //     List<Map<String, dynamic>> orders) async {
  //   isCreateOrderLoading = true;
  //   notifyListeners();
  //   final response = await _service.createOrders(orders);
  //   isCreateOrderLoading = false;
  //   notifyListeners();
  //   return response;
  // }
  bool isCreateOrderLoading = false;

  Future<Map<String, dynamic>> createOrder(int shippingLocationid,
      List<Map<String, dynamic>> orders) async {
    isCreateOrderLoading = true;
    notifyListeners();

    try {
      // logger.log("orders: ${orders.toString()}");
      final response = await _service.createOrders(shippingLocationid, orders);
      return response;
    } catch (e) {
      // Log the error and re-throw it to handle it in the calling function
      logger.log("Error creating order: $e");
      throw "$e";
    } finally {
      // Reset the loading state, regardless of success or failure
      isCreateOrderLoading = false;
      notifyListeners();
    }
  }
}
