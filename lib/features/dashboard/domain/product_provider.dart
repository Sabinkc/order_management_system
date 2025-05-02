import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'dart:developer' as logger;

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
      ProductCategory(
          id: 0,
          name: "All",
          productsCount: product.length,
          categoryImage: "not availiable"),
      ...response
    ];
    logger.log(
        "get all product categories called with calling calling without all categories");
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
  bool hasMoreAllProduct = true;
  int allProductPage = 1;

  Future<void> getAllProduct(String s) async {
    if (isProductLoading || !hasMoreAllProduct) {
      return;
    }
    isProductLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAllProducts(s, allProductPage);
      if (response.isEmpty) {
        hasMoreAllProduct = false;
      } else {
        final newProduct = response;
        product.addAll(newProduct);
        allProductPage += 1;
        // logger.log("products: $product");
        notifyListeners();
      }
    } catch (e) {
      logger.log("provider error: $e");
    } finally {
      isProductLoading = false;
      notifyListeners();
    }
  }

  void resetAllProducts() {
    isProductLoading = false;
    product.clear();
    hasMoreAllProduct = true;
    allProductPage = 1;
  }

  // Provider to fetch all offer products
  bool isOfferProductLoading = false;
  List offerProduct = [];
  bool hasMoreOfferProduct = true;
  int offerProductPage = 1;

  Future<void> getOfferProduct(String s) async {
    if (isOfferProductLoading || !hasMoreOfferProduct) {
      return;
    }
    isOfferProductLoading = true;
    notifyListeners();
    try {
      final response = await _service.getOfferProducts(s, offerProductPage);
      if (response.isEmpty) {
        hasMoreOfferProduct = false;
      } else {
        final newProduct = response;
        offerProduct.addAll(newProduct);
        offerProductPage += 1;
        logger.log("offer products: $product");
        notifyListeners();
      }
    } catch (e) {
      logger.log("provider error: $e");
    } finally {
      isOfferProductLoading = false;
      notifyListeners();
    }
  }

  void resetOfferProducts() {
    isOfferProductLoading = false;
    offerProduct.clear();
    hasMoreOfferProduct = true;
    offerProductPage = 1;
  }

  // Provider to fetch all product widget
  bool isWidgetProductLoading = false;
  List widgetProduct = [];
  bool hasMoreWidgetProduct = true;
  int widgetProductPage = 1;

  Future<void> getWidgetProduct(String s) async {
    if (isWidgetProductLoading || !hasMoreWidgetProduct) {
      return;
    }
    isWidgetProductLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAllProducts(s, widgetProductPage);
      if (response.isEmpty) {
        hasMoreWidgetProduct = false;
      } else {
        final newProduct = response;
        widgetProduct.addAll(newProduct);
        widgetProductPage += 1;
        logger.log("widget product: ${widgetProduct.length}");
        notifyListeners();
      }
    } catch (e) {
      logger.log("$e");
    } finally {
      isWidgetProductLoading = false;
      notifyListeners();
    }
  }

  void resetWidgetProducts() {
    isWidgetProductLoading = false;
    widgetProduct.clear();
    hasMoreWidgetProduct = true;
    widgetProductPage = 1;
  }

  bool isCategoryProductLoading = false;
  List categoryProducts = [];
  int categoryProductPage = 1;
  bool hasMoreCategoryProducts = true;

  Future<void> getCategoryProducts(int categoryId, String s,
      {bool reset = false}) async {
    logger.log("passed category id: $categoryId, passed search Keyword:$s");
    if (isCategoryLoading) return;

    // Reset pagination and clear products if needed
    if (reset) {
      categoryProducts.clear();
      categoryProductPage = 1;
      categoryProducts.clear();
      hasMoreCategoryProducts = true;
    }

    if (!hasMoreCategoryProducts) return;

    isCategoryProductLoading = true;
    notifyListeners();

    try {
      List newProducts;
      if (categoryId == 0) {
        newProducts = await _service.getAllProducts(s, categoryProductPage);
      } else {
        newProducts = await _service.getProductsByCategory(
            categoryId, s, categoryProductPage);
      }

      if (newProducts.isEmpty) {
        hasMoreCategoryProducts = false;
      } else {
        // Always add to the list for consistent pagination behavior
        categoryProducts.addAll(newProducts);
        categoryProductPage += 1;
      }
      // logger.log("category Products: $categoryProducts");
      logger.log("category product length: ${categoryProducts.length}");
      // Update filtered products
      // filteredCategoryProducts = List.from(categoryProducts);
      // logger.log(
      //     "Fetched ${newProducts.length} products for category $categoryId");
      // logger.log("Total products now: ${categoryProducts.length}");
    } catch (e) {
      logger.log("Error fetching products: $e");
      hasMoreCategoryProducts = false;
    } finally {
      isCategoryProductLoading = false;
      notifyListeners();
    }
  }

  bool isWidgetCategoryProductLoading = false;
  List widgetCategoryProducts = [];
  int widgetCategoryProductPage = 1;
  bool hasMoreWidgetCategoryProducts = true;

  Future<void> getWidgetCategoryProducts(int categoryId, String s,
      {bool reset = false}) async {
    logger.log("passed category id: $categoryId, passed search Keyword:$s");
    if (isWidgetCategoryProductLoading) return;

    // Reset pagination and clear products if needed
    if (reset) {
      widgetCategoryProducts.clear();
      widgetCategoryProductPage = 1;
      hasMoreWidgetCategoryProducts = true;
    }

    if (!hasMoreWidgetCategoryProducts) return;

    isWidgetCategoryProductLoading = true;
    notifyListeners();

    try {
      List newProducts;
      if (categoryId == 0) {
        newProducts =
            await _service.getAllProducts(s, widgetCategoryProductPage);
      } else {
        newProducts = await _service.getProductsByCategory(
            categoryId, s, widgetCategoryProductPage);
      }

      if (newProducts.isEmpty) {
        hasMoreWidgetCategoryProducts = false;
      } else {
        // Always add to the list for consistent pagination behavior
        widgetCategoryProducts.addAll(newProducts);
        widgetCategoryProductPage += 1;
      }
      // logger.log("category Products: $categoryProducts");
      logger.log("category product length: ${widgetCategoryProducts.length}");
      // Update filtered products
      // filteredCategoryProducts = List.from(categoryProducts);
      // logger.log(
      //     "Fetched ${newProducts.length} products for category $categoryId");
      // logger.log("Total products now: ${categoryProducts.length}");
    } catch (e) {
      logger.log("Error fetching products: $e");
      hasMoreWidgetCategoryProducts = false;
    } finally {
      isWidgetCategoryProductLoading = false;
      notifyListeners();
    }
  }

  bool isProductDetailLoading = false;
  ProductDetails productDetail = ProductDetails(
      name: "",
      description: "",
      categoryName: "",
      imageUrl: "",
      stockQuantity: 0,
      price: 0,
      isAvailable: true,
      images: [],
      sku: "");
  Future getProductDetail(String sku) async {
    isProductDetailLoading = true;
    notifyListeners();
    try {
      final response = await _service.getProductDetailsById(sku);
      productDetail = response;
      logger.log(productDetail.toString());
    } catch (e) {
      logger.log("$e");
    } finally {
      isProductDetailLoading = false;
      notifyListeners();
    }
  }

  bool isImageLoading = false;
  Uint8List productImage = Uint8List(10);
  Future<Uint8List> getProductImage(String imageUrl) async {
    isImageLoading = true;
    notifyListeners();

    Uint8List imageData = await _service.getImageByFilename(imageUrl);

    productImage = imageData;
    isImageLoading = false;
    notifyListeners();

    return productImage;
  }

  void resetCategoryProducts() {
    categoryProducts.clear();
    hasMoreCategoryProducts = true;
    categoryProductPage = 1;
    isCategoryProductLoading = false;
    notifyListeners();
  }

  // //provider to create orders
  bool isCreateOrderLoading = false;

  Future<Map<String, dynamic>> createOrder(
      int shippingLocationid, List<Map<String, dynamic>> orders) async {
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

  bool isGetAllInvoiceLoading = false; // Loading state
  List<InvoiceModel> invoices = []; // Stores all orders from the API
  bool allInvoiceHasMore = true;

  int invoicePage = 1;
  Future<void> getAllInvoice(
      bool reset, String paidStatus, String startDate, String endDate) async {
    if (reset) {
      invoicePage = 1;
      allInvoiceHasMore = true;
      invoices.clear();
      isGetAllInvoiceLoading = false;
      notifyListeners();
    }
    // logger.log(
    // "page:$invoicePage, status: $paidStatus, startDate: $startDate, endDate: $endDate");
    if (isGetAllInvoiceLoading || !allInvoiceHasMore) return;
    isGetAllInvoiceLoading = true;
    notifyListeners();

    try {
      final response = await _service.getAllInvoiceByStatusAndDate(
          invoicePage, paidStatus, startDate, endDate);
      if (response.isEmpty) {
        allInvoiceHasMore = false;
      } else {
        invoices.addAll(response);
        invoicePage++;
        // logger.log("invoices: $invoices");
        notifyListeners();
      }
    } catch (e) {
      logger.log("$e");
    } finally {
      isGetAllInvoiceLoading = false;
      notifyListeners();
    }
  }

  void resetAllInvoice() {
    invoicePage = 1;
    allInvoiceHasMore = true;
    invoices.clear();
    isGetAllInvoiceLoading = false;
    notifyListeners();
  }

  List<InvoiceModel> searchedInvoice = [];

  InvoiceModel invoiceDetail = InvoiceModel(
      invoiceNo: "",
      totalAmount: "",
      date: "",
      totalQuantity: 0,
      paidStatus: "",
      products: [],
      receiverName: "",
      receiverEmail: "",
      receiverPhone: "",
      receiverPrefecture: "",
      receiverCity: "",
      receiverArea: "");
  // List<OrderModel> searchedInvoice = [];
  bool isFetchInvoiceByNoLoading = false;

  Future fetchInvoiceByNo(String invoiceNo) async {
    isFetchInvoiceByNoLoading = true;
    notifyListeners();
    try {
      InvoiceModel response = await _service.getInvoiceByInvoiceno(invoiceNo);

      invoiceDetail = response;
      searchedInvoice = [invoiceDetail];
      logger.log("invoice by key: $invoiceDetail");
    } catch (e) {
      logger.log("$e");
      searchedInvoice.clear();
    } finally {
      isFetchInvoiceByNoLoading = false;
      notifyListeners();
    }
  }

  void clearSearchedInvoice() {
    searchedInvoice = [];
    isFetchInvoiceByNoLoading = false;
    notifyListeners();
  }
}
