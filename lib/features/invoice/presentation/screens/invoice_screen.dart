import 'package:flutter/material.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_detail_screen.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_history_screen.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceScreenProvider>(
        builder: (context, invoicescreenProvider, child) {
      return invoicescreenProvider.isInvoiceDetailPage == true
          ? InvoiceDetailScreen(
              orderKey: invoicescreenProvider.orderKey,
            )
          : InvoiceHistoryScreen();
    });
  }
}
