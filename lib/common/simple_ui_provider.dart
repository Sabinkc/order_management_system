import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SimpleUiProvider extends ChangeNotifier {
  final Logger logger = Logger();

//provider to filter by status
  String selectedStatus = "";
  void switchSelectedStatus(String value) {
    selectedStatus = value;
    logger.i("selected status: $selectedStatus");
    notifyListeners();
  }

//provider to filter invoice based on date
  String _selectedStartDate = "";
  String _selectedEndDate = "";

  String get selectedStartDate => _selectedStartDate;
  String get selectedEndDate => _selectedEndDate;

  void setSelectedStartDate(String date) {
    _selectedStartDate = date;
    notifyListeners();
  }

  void setSelectedEndDate(String date) {
    _selectedEndDate = date;
    notifyListeners();
  }

  void clearDateRange() {
    _selectedStartDate = "";
    _selectedEndDate = "";
    notifyListeners();
  }

  void clearFilter() {
    selectedStatus = "";
    _selectedStartDate = "";
    _selectedEndDate = "";
    notifyListeners();
  }

    String selectedInvoiceStatus = "";
  void switchSelectedInvoiceStatus(String value) {
    selectedInvoiceStatus = value;
    logger.i("selected Invoice status: $selectedInvoiceStatus");
    notifyListeners();
  }

//provider to filter invoice based on date
  String _selectedInvoiceStartDate = "";
  String _selectedInvoiceEndDate = "";

  String get selectedInvoiceStartDate => _selectedInvoiceStartDate;
  String get selectedInvoiceEndDate => _selectedInvoiceEndDate;

  void setSelectedInvoiceStartDate(String date) {
    _selectedInvoiceStartDate = date;
    notifyListeners();
  }

  void setSelectedInvoiceEndDate(String date) {
    _selectedInvoiceEndDate = date;
    notifyListeners();
  }

  void clearInvoiceDateRange() {
    _selectedInvoiceStartDate = "";
    _selectedInvoiceEndDate = "";
    notifyListeners();
  }

  void clearInvoiceFilter() {
    selectedInvoiceStatus = "";
    _selectedInvoiceStartDate = "";
    _selectedInvoiceEndDate = "";
    notifyListeners();
  }

  int carouselIndex = 0;
   void updateCarouselIndex(int index){
    carouselIndex = index;
    notifyListeners();
   }

   void clearCarouselIndex(){
    carouselIndex=0;
    notifyListeners();
   }
}
