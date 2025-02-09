import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class InvoiceScreenProvider extends ChangeNotifier {
  bool isInvoiceDetailPage = false;

  void switchInvoiceDetailPage() {
    isInvoiceDetailPage = !isInvoiceDetailPage;
    notifyListeners();
    final Logger logger = Logger();
    logger.i("isInvocieDetailPage: $isInvoiceDetailPage");
  }

  int invoiceIndex=0;

  selectInvoiceIndex(int index){
invoiceIndex = index;
notifyListeners();
  }
}
