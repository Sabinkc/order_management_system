class CartModel {
  final String id;
  final String productName;
  final String imagePath;
  final int price;
  int quantity;
  final String category;

  CartModel({
    required this.id,
    required this.productName,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.category,
  });
}
