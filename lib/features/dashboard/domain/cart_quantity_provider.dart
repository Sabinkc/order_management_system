import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

class CartQuantityProvider extends ChangeNotifier {
  List<CartModel> cartItems = [];

  void addToCart(String productId, BuildContext context) {
    final products =
        Provider.of<ProductProvider>(context, listen: false).product;
    // Check if the product is already in the cart
    final existingIndex = cartItems.indexWhere((item) => item.id == productId);

    if (existingIndex != -1) {
      // If the product is already in the cart, increase its quantity
      cartItems[existingIndex].quantity += 1;
    } else {
      // Find the product from the `products` list using its `product_id`
      final productIndex =
          products.indexWhere((product) => product.id.toString() == productId);
          logger.log(productIndex.toString());

      if (productIndex != -1) {
        // Add the product to the cart
        final product = products[productIndex];
        cartItems.add(
          CartModel(
            id: product.id.toString(),
            productName: product.name,
            price: product.price,
            category: product.categoryName,
            imagePath: product.imageUrl,
            quantity: 1, // Default quantity
          ),
          //      cartItems.add(CartModel(
          //   id: "1",
          //   productName: "product",
          //   price: 300,
          //   category: "Clothing",
          //   imagePath: "url",
          //   quantity: 1, // Default quantity
          // ),
        );
      } else {
        // print("Product with ID $productId not found.");
      }
    }
    logger.log("cartItems after addition: $cartItems");
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  int getTotalQuantity() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void updateQuantity(String productId, int quantityChange) {
    final existingIndex = cartItems.indexWhere((item) => item.id == productId);

    if (existingIndex != -1) {
      final updatedQuantity =
          cartItems[existingIndex].quantity + quantityChange;

      if (updatedQuantity > 0) {
        // Update quantity if it doesn't drop below 1
        cartItems[existingIndex].quantity = updatedQuantity;
      } else {
        // Remove item from cart if quantity becomes 0
        cartItems.removeAt(existingIndex);
      }
      notifyListeners(); // Notify UI to rebuild
    }
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
