import 'package:flutter/material.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';

class InvoiceScreenProvider extends ChangeNotifier {
  final ProductApiSevice productApiSevice = ProductApiSevice();
  bool isInvoiceDetailPage = false;

  void switchInvoiceDetailPage() {
    isInvoiceDetailPage = !isInvoiceDetailPage;
    notifyListeners();

    logger.log("isInvocieDetailPage: $isInvoiceDetailPage");
  }

  String orderKey = "";

  selectInvoiceKey(String oKey) {
    orderKey = oKey;
    notifyListeners();
  }

  InvoiceModel invoiceDetail = InvoiceModel(
      orderNo: "",
      totalAmount: "",
      date: "",
      totalQuantity: 0,
      status: "",
      products: []);
  bool isFetchOrderByLoading = false;

  Future fetchOrderByorderKey(String orderKey) async {
    isFetchOrderByLoading = true;
    notifyListeners();
    InvoiceModel response = await productApiSevice.getOrderByKey(orderKey);
    invoiceDetail = response;
    isFetchOrderByLoading = false;
    notifyListeners();
  }

  bool isGetAllOrderLoading = false; // Loading state
  List<InvoiceModel> allOrders = []; // Stores all orders from the API

  // Filter-related properties
  String _selectedFilter = "all_status"; // Default filter
  DateTime? _startDate;
  DateTime? _endDate;

  final ProductApiSevice _service = ProductApiSevice(); // Your API service

  // Fetch all orders from the API
  Future<void> getAllOrder() async {
    isGetAllOrderLoading = true;
    notifyListeners();
    final response = await _service.getAllMyOrders();
    allOrders = response;
    logger.log("All orders: $allOrders");
    isGetAllOrderLoading = false;
    notifyListeners();
  }

      final TextEditingController searchController = TextEditingController();

  String _searchKeyword = ""; // Store the search keyword

  // Getter for search keyword
  String get searchKeyword => _searchKeyword;

  // Method to update the search keyword
  void updateSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    logger.log(_searchKeyword);
    notifyListeners();
  }

  void clearSearchKeyword(){
    _searchKeyword="";
     notifyListeners();
    // logger.log("search keyword after clearing: $_searchKeyword");
    searchController.clear();
    notifyListeners();
  }

  // Getter for filtered orders
  List<InvoiceModel> get filteredOrders {
    logger.log("Selected filter: $_selectedFilter");

    // First, filter by status if a specific status is selected
    List<InvoiceModel> statusFilteredOrders = allOrders;

    if (_selectedFilter != 'all_status') {
      statusFilteredOrders = allOrders.where((order) {
        return order.status.toLowerCase() == _selectedFilter.toLowerCase();
      }).toList();
    }

    // Then, filter by date range if start and end dates are provided
    if (_startDate != null && _endDate != null) {
      statusFilteredOrders = statusFilteredOrders.where((order) {
        final orderDate = DateTime.parse(order.date); // Parse the date string
        return orderDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            orderDate.isBefore(_endDate!.add(Duration(days: 1)));
      }).toList();
    }

    if (_searchKeyword.isNotEmpty) {
      statusFilteredOrders = statusFilteredOrders.where((order) {
        return order.orderNo
            .toLowerCase()
            .contains(_searchKeyword.toLowerCase());
      }).toList();
    }
    logger.log("filteredOrders: $statusFilteredOrders");
    return statusFilteredOrders;
  }

  // Method to set filters
  void setFilter(String filter, {DateTime? startDate, DateTime? endDate}) {
    _selectedFilter = filter;
    _startDate = startDate;
    _endDate = endDate;

    logger.log(
        "Selected filter = $_selectedFilter, startDate = $_startDate, endDate = $_endDate");
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedFilter = "all_status";
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }
}
