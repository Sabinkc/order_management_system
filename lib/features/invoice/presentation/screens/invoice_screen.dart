// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';

// class InvoiceScreen extends StatelessWidget {
//   const InvoiceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: RichText(
//             text: TextSpan(children: [
//           TextSpan(
//             text: "Inv",
//             style: TextStyle(
//                 fontSize: 22,
//                 color: CommonColor.primaryColor,
//                 fontWeight: FontWeight.bold),
//           ),
//           TextSpan(
//             text: "oice",
//             style: TextStyle(
//                 fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ])),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Text("Invoice screen"),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  // Dummy data for demonstration
  final List<Map<String, dynamic>> invoices = const [
    {
      'invoiceNumber': '#12345',
      'date': '2023-10-01',
      'amount': 'Rs.1500',
      'status': 'Paid',
    },
    {
      'invoiceNumber': '#12346',
      'date': '2023-10-05',
      'amount': 'Rs.2000',
      'status': 'Pending',
    },
    {
      'invoiceNumber': '#12347',
      'date': '2023-10-10',
      'amount': 'Rs.3000',
      'status': 'Paid',
    },
    {
      'invoiceNumber': '#12348',
      'date': '2023-10-15',
      'amount': 'Rs.700',
      'status': 'Overdue',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Inv",
                style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "oice",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invoice History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "Sort",
                      style: TextStyle(
                        color: CommonColor.mediumGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: CommonColor.mediumGreyColor,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                invoice['invoiceNumber'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(invoice['status']),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  invoice['status'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Date: ${invoice['date']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Amount: ${invoice['amount']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
