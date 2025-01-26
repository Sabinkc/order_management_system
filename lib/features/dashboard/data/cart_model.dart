// class CartModel {
//   final String productName;
//   final int price;
//   final String category;
// final String imagePath; 
// final int quantity;
// final String id;

// CartModel({required this.productName, required this.price, required this.category, required this.imagePath, required this.id, required this.quantity});
// }

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
