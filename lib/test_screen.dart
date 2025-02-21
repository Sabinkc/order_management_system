import 'package:flutter/material.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                final ProductApiSevice productApiSevice = ProductApiSevice();
                productApiSevice.getProductsByAvailability(0);
              },
              child: Text("Press")),
          Center(child: Text("Test Screen")),
        ],
      ),
    );
  }
}
