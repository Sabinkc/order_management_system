class CartModel {
  final String id;
  final String productName;
  final double price;
  final String category;
  final String imagePath;
  final String sku;
  int quantity;

  CartModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.category,
    required this.imagePath,
    required this.sku,
    this.quantity = 1,
  });
  @override
  String toString() {
    return 'CartModel(id: $id, productName: $productName, imagePath: $imagePath, price: $price, quantity: $quantity, category: $category,sku: $sku)';
  }
}
