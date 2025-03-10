// import 'package:flutter/material.dart';
// import 'package:order_management_system/features/order/domain/invoice_screen_provider.dart';
// import 'package:order_management_system/features/order/presentation/screens/order_detail_screen.dart';
// import 'package:order_management_system/features/order/presentation/screens/order_history_screen.dart';
// import 'package:provider/provider.dart';

// class InvoiceScreen extends StatelessWidget {
//   const InvoiceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InvoiceScreenProvider>(
//         builder: (context, invoicescreenProvider, child) {
//       return invoicescreenProvider.isInvoiceDetailPage == true
//           ? InvoiceDetailScreen(
//               orderKey: invoicescreenProvider.orderKey,
//             )
//           : InvoiceHistoryScreen();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/features/order/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/order/presentation/screens/order_detail_screen.dart';
import 'package:order_management_system/features/order/presentation/screens/order_history_screen.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceScreenProvider>(
        builder: (context, invoicescreenProvider, child) {
      return invoicescreenProvider.isInvoiceDetailPage == true
          ? OrderDetailScreen(
              orderKey: invoicescreenProvider.orderKey,
            )
          : OrderHistoryScreen();
    });
  }
}
