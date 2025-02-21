final List<Map<String,dynamic>> products = [
  {
    "product_id": "1",
    "name": "Amul Cheese - 100 Slices, 200g",
    "image": "assets/images/amulcheese.png",
    "description":
        "High-quality wireless Bluetooth headphones with noise cancellation and long battery life.",
    "price": 300,
    "category": "Diary & Milk",
  },
  {
    "product_id": "2",
    "name": "Cetaphil - 100 pieces, 1kg",
    "image": "assets/images/cetaphil.png",
    "description":
        "A smartwatch that tracks your heart rate, steps, and provides notifications on the go.",
    "price": 400,
    "category": "Cosmetic"
  },
  {
    "product_id": "3",
    "name": "Real juice Flavoured Cold Drink",
    "image": "assets/images/realjuice.png",
    "description":
        "A compact and powerful portable power bank to charge your devices on the go.",
    "price": 500,
    "category": "Cold Drink"
  },
  {
    "product_id": "4",
    "name": "Sprite Lemon-Lime Flavoured Cold Drink",
    "image": "assets/images/sprite.png",
    "description":
        "A 55-inch 4K Ultra HD Smart TV with voice control and smart features.",
    "price": 300,
    "category": "Cold Drink"
  },
  {
    "product_id": "5",
    "name": "Nature's Way Kids Smart Omega3 Fish Oil 60s",
    "image": "assets/images/vitamin.png",
    "description":
        "High-quality wireless Bluetooth headphones with noise cancellation and long battery life.",
    "price": 100,
    "category": "Vitamin"
  },
  {
    "product_id": "6",
    "name": "Cold Drink Xtreme Drink 200ml",
    "image": "assets/images/xtremedrink.png",
    "description":
        "A smartwatch that tracks your heart rate, steps, and provides notifications on the go.",
    "price": 900,
    "category": "Cold Drink"
  },
  {
    "product_id": "7",
    "name": "Mazza Original Mango Juice",
    "image": "assets/images/realjuice.png",
    "description":
        "A compact and powerful portable power bank to charge your devices on the go.",
    "price": 1000,
    "category": "Cold Drink"
  },
  {
    "product_id": "8",
    "name": "Sprite Lemon-Lime Flavoured Cold Drink",
    "image": "assets/images/sprite.png",
    "description":
        "A 55-inch 4K Ultra HD Smart TV with voice control and smart features.",
    "price": 700,
    "category": "Cold Drink"
  },
  {
    "product_id": "9",
    "name": "Nature's Way Kids Smart Omega3 Fish Oil 60s",
    "image": "assets/images/vitamin.png",
    "description":
        "High-quality wireless Bluetooth headphones with noise cancellation and long battery life.",
    "price": 555,
    "category": "Vitamin"
  },
  {
    "product_id": "10",
    "name": "Cetaphil Moustarizing Lotion 300 ML",
    "image": "assets/images/cetaphil.png",
    "description":
        "A smartwatch that tracks your heart rate, steps, and provides notifications on the go.",
    "price": 250,
    "category": "Cosmetic"
  },
  {
    "product_id": "11",
    "name": "Real Juice Flavoured Cold Drink",
    "image": "assets/images/realjuice.png",
    "description":
        "A smartwatch that tracks your heart rate, steps, and provides notifications on the go.",
    "price": 250,
    "category": "Cold Drink"
  },
];

class Product {
  final int id;
  final String name;
  final String description;
  final String categoryName;
  final String imageUrl;
  final int stockQuantity;
  final double price;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.imageUrl,
    required this.stockQuantity,
    required this.price,
    required this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryName: json['category']['name'],
      imageUrl: json['unitTypes'][0]['images'][0] ?? '',
      stockQuantity: json['unitTypes'][0]['stockQuantity'],
      price: double.parse(json['unitTypes'][0]['price']),
      isAvailable: json['isAvailable'],
    );
  }
}
