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
              onPressed: () async {
                // final orderProvider =
                //     Provider.of<OrderScreenProvider>(context, listen: false);
                // orderProvider.getAllOrder();
                // final productProvider =
                //     Provider.of<ProductProvider>(context, listen: false);
                // productProvider.getAllInvoice(true, "", "", "");
                final productApiService = ProductApiSevice();
                // productApiService.getInvoiceByInvoiceno("2-3-4-n");
                productApiService.getAllInvoiceByStatusAndDate(1, "", "", "");

                // final orderProvider =
                //     Provider.of<OrderScreenProvider>(context, listen: false);
                // orderProvider.getOrderByStatusAndDate("pending", "", "");
              },
              child: Text("Press")),
          Center(child: Text("Test Screen")),
        ],
      ),
    );
  }
}

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}

// import 'package:flutter/material.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Text("Invoice Screen")),
//     );
//   }
// }
