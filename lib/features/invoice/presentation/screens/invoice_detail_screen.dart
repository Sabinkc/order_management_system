import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/invoice/domain/invoice_screen_provider.dart';
import 'package:provider/provider.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceScreenProvider>(builder: (context,invoiceScreenProvider,child){
      return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
               Provider.of<InvoiceScreenProvider>(context,listen: false).switchInvoiceDetailPage();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColor.primaryColor,
            )),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Invoice",
            style: TextStyle(
                fontSize: 22,
                color: CommonColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "Details",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
    });
  }
}
