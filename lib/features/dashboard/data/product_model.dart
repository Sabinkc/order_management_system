class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
  });
}

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
  });

  @override
  String toString() {
    return 'ProductDetails{id: $id, name: $name, description: $description, categoryName: $categoryName, stockQuantity: $stockQuantity, price: $price, isAvailable: $isAvailable, imageUrl: $imageUrl}';
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

class ProductImage {
  final String imageData; // base64 string or URL

  ProductImage({
    required this.imageData,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageData: json['data'], // Or however the image data is returned
    );
  }
}
