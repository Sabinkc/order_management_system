import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/invoice/presentation/screens/invoice_detail_screen.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) {
        return;
      }
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      await productProvider.getAllInvoice(true, "", "", "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "My Invoices",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
            return productProvider.isGetAllInvoiceLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: CommonColor.primaryColor,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Search invoice no...",
                              hintStyle: TextStyle(
                                  color: CommonColor.darkGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 25,
                                color: CommonColor.primaryColor,
                              ),
                              suffixIcon: Theme(
                                data: ThemeData(
                                    popupMenuTheme: PopupMenuThemeData(
                                  color: Colors.white,
                                )),
                                child: PopupMenuButton(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/filter.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 0,
                                          bottom: 0,
                                        ),
                                        onTap: () {
                                          showFilterDialog(context);
                                        },
                                        child: const Center(
                                            child: Text("Search filters")),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 30,
                                  maxWidth: 30,
                                  minHeight: 30,
                                  minWidth: 30),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey[100]!), // Transparent border
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CommonColor.primaryColor,
                                    width: 2), // Focused border color
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2), // Error border color
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2), // Focused error border color
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey[100]!), // Disabled border color
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () async {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                "Reset filter",
                                style: TextStyle(
                                    color: CommonColor.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Divider(
                          color: CommonColor.commonGreyColor,
                          thickness: 2,
                        ),
                        Expanded(
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: productProvider.invoices.length,
                              itemBuilder: (context, index) {
                                final invoice = productProvider.invoices[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InvoiceDetailScreen(
                                                      invoiceNo:
                                                          invoice.invoiceNo)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Invoice No: ${invoice.invoiceNo}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColor
                                                        .darkGreyColor),
                                              ),
                                              Text(
                                                "Rs.${invoice.totalAmount}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status: ",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .darkGreyColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    invoice.paidStatus == false
                                                        ? "Unpaid"
                                                        : "Paid",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                invoice.date,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                  color: CommonColor
                                                      .mediumGreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
          })),
    );
  }

  //logical part
  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search filter by:",
                style: TextStyle(
                  color: CommonColor.darkGreyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Date:",
                      style: TextStyle(color: CommonColor.darkGreyColor)),
                  TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {}
                    },
                    child: Text(
                      "Start Date",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text("to",
                      style: TextStyle(color: CommonColor.darkGreyColor)),
                  TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {}
                    },
                    child: Text(
                      "End Date",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Clear date range",
                  style: TextStyle(
                      // decoration: TextDecoration.underline,
                      color: CommonColor.darkGreyColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Row(
                children: [
                  Text("Status:",
                      style: TextStyle(color: CommonColor.darkGreyColor)),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: "all_status",
                    items: [
                      DropdownMenuItem(value: "all_status", child: Text("All")),
                      DropdownMenuItem(value: "paid", child: Text("Paid")),
                      DropdownMenuItem(value: "un_paid", child: Text("Unpaid")),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Apply"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
