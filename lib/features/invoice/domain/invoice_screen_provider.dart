// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// class InvoiceScreenProvider extends ChangeNotifier {
//   bool isInvoiceDetailPage = false;

//   void switchInvoiceDetailPage() {
//     isInvoiceDetailPage = !isInvoiceDetailPage;
//     notifyListeners();
//     final Logger logger = Logger();
//     logger.i("isInvocieDetailPage: $isInvoiceDetailPage");
//   }

//   int invoiceIndex=0;

//   selectInvoiceIndex(int index){
// invoiceIndex = index;
// notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';

class InvoiceScreenProvider extends ChangeNotifier {
  final ProductApiSevice productApiSevice = ProductApiSevice();
  bool isInvoiceDetailPage = false;

  void switchInvoiceDetailPage() {
    isInvoiceDetailPage = !isInvoiceDetailPage;
    notifyListeners();
    final Logger logger = Logger();
    logger.i("isInvocieDetailPage: $isInvoiceDetailPage");
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
}
