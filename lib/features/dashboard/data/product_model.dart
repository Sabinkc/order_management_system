class ProductDetails {
  // final int id;
  final String name;
  final String description;
  final String categoryName;
  final String imageUrl;
  final int stockQuantity;
  final double price;
  final bool isAvailable;
  final List<dynamic> images;
  final String sku;

  ProductDetails({
    // required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.imageUrl,
    required this.stockQuantity,
    required this.price,
    required this.isAvailable,
    required this.images,
    required this.sku,
  });

  @override
  String toString() {
    return 'ProductDetails{ name: $name, description: $description, categoryName: $categoryName, stockQuantity: $stockQuantity, price: $price, isAvailable: $isAvailable, imageUrl: $imageUrl, sku: $sku,images:$images}';
  }
}

class OfferProductDetails {
  // final int id;
  final String name;
  final String description;
  final String categoryName;
  final String imageUrl;
  final int stockQuantity;
  final double price;
  final bool isAvailable;
  final List<dynamic> images;
  final String sku;
  final String discountPercent;

  OfferProductDetails({
    // required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.imageUrl,
    required this.stockQuantity,
    required this.price,
    required this.isAvailable,
    required this.images,
    required this.sku,
    required this.discountPercent,
  });

  @override
  String toString() {
    return 'ProductDetails{ name: $name, description: $description, categoryName: $categoryName, stockQuantity: $stockQuantity, price: $price, isAvailable: $isAvailable, imageUrl: $imageUrl, sku: $sku,images:$images,discountPercent: $discountPercent}';
  }
}

class ProductCategory {
  final int id;
  final String name;
  final int productsCount;
  final String categoryImage;

  ProductCategory({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.categoryImage,
  });

  @override
  String toString() {
    return 'ProductCategory(id: $id, name: $name, productsCount: $productsCount), categoryImage: $categoryImage';
  }
}

class OrderModel {
  final String orderNo;
  final String totalAmount;
  final String date;
  final int totalQuantity;
  final String status;
  final List<OrderProductDetailModel> products;

  OrderModel({
    required this.orderNo,
    required this.totalAmount,
    required this.date,
    required this.totalQuantity,
    required this.status,
    required this.products,
  });

  @override
  String toString() {
    return 'InvoiceModel(orderNo: $orderNo, totalAmount: $totalAmount, date: $date, totalQuantity: $totalQuantity, status: $status, products: $products)';
  }
}

class OrderProductDetailModel {
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String imagePath;

  OrderProductDetailModel({
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });

  @override
  String toString() {
    return 'InvoiceProductDetailModel(name: $name, category: $category, quantity: $quantity, price: $price, imagePath: $imagePath)';
  }
}

class InvoiceModel {
  final String invoiceNo;
  final String totalAmount;
  final String date;
  final int totalQuantity;
  final String paidStatus;
  final List<OrderProductDetailModel> products;
  String receiverName;
  String receiverPhone;
  String receiverEmail;
  String receiverPrefecture;
  String receiverCity;
  String receiverArea;

  InvoiceModel(
      {required this.invoiceNo,
      required this.totalAmount,
      required this.date,
      required this.totalQuantity,
      required this.paidStatus,
      required this.products,
      required this.receiverName,
      required this.receiverPhone,
      required this.receiverEmail,
      required this.receiverPrefecture,
      required this.receiverCity,
      required this.receiverArea});

  @override
  String toString() {
    return 'InvoiceModel(orderNo: $invoiceNo, totalAmount: $totalAmount, date: $date, totalQuantity: $totalQuantity, status: $paidStatus, products: $products, receiverName: $receiverName, receiverPhone: $receiverPhone, receiverEmail: $receiverEmail, receiverPrefecture: $receiverPrefecture, rceiverCity: $receiverArea, receiverArea: $receiverArea)';
  }
}
