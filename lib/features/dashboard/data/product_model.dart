class ProductDetails {
  final int id;
  final String name;
  final String description;
  final String categoryName;
  final String imageUrl;
  final int stockQuantity;
  final double price;
  final bool isAvailable;
  // final List<String> images;
  final String sku;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.imageUrl,
    required this.stockQuantity,
    required this.price,
    required this.isAvailable,
    // required this.images,
    required this.sku,
  });

  @override
  String toString() {
    return 'ProductDetails{id: $id, name: $name, description: $description, categoryName: $categoryName, stockQuantity: $stockQuantity, price: $price, isAvailable: $isAvailable, imageUrl: $imageUrl, sku: $sku}';
  }
}

class ProductCategory {
  final int id;
  final String name;
  final int productsCount;

  ProductCategory({
    required this.id,
    required this.name,
    required this.productsCount,
  });

  @override
  String toString() {
    return 'ProductCategory(id: $id, name: $name, productsCount: $productsCount)';
  }
}

class InvoiceModel {
  final String orderNo;
  final String totalAmount;
  final String date;
  final int totalQuantity;
  final String status;
  final List<InvoiceProductDetailModel> products;

  InvoiceModel({
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
class InvoiceProductDetailModel {
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String imagePath;

  InvoiceProductDetailModel({
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

