import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Invoice Details",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text("Receipt"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prepared for",
                      style: TextStyle(
                          color: CommonColor.mediumGreyColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "John Wilson",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "9812060688",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "johnwilson@gmail.com",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "Shankhamul, Kathmandu",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                        color: CommonColor.mediumGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "2025-02-01",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              )
            ],
          ),
          Divider(
            color: CommonColor.commonGreyColor,
            thickness: 2,
            height: screenHeight * 0.05,
          ),

          Text(
            "Invoice Summary",
            style: TextStyle(
                color: CommonColor.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products",
                  style: TextStyle(color: CommonColor.mediumGreyColor),
                ),
                Text(
                  "Amount",
                  style: TextStyle(color: CommonColor.mediumGreyColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          // Divider(
          //   color: CommonColor.commonGreyColor,
          //   thickness: 2,
          //   // height: screenHeight * 0.05,
          // ),
          // SizedBox(
          //   height: screenHeight * 0.01,
          // ),
          Expanded(
            // height: 200,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "5 T shirts",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Rs.500",
                                  style: TextStyle(
                                      color: CommonColor.mediumGreyColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Divider(
                              color: CommonColor.commonGreyColor,
                              thickness: 2,
                              // height: screenHeight * 0.05,
                            ),
                          ],
                        ));
                  }),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invoice no",
                style: TextStyle(
                  color: CommonColor.mediumGreyColor,
                ),
              ),
              Text(
                "012345",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              )
            ],
          ),
          Divider(
            color: CommonColor.commonGreyColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invoice status",
                style: TextStyle(
                  color: CommonColor.mediumGreyColor,
                ),
              ),
              Text(
                "Paid",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              )
            ],
          ),
          Divider(
            color: CommonColor.commonGreyColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  color: CommonColor.mediumGreyColor,
                ),
              ),
              Text(
                "Rs.500",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              )
            ],
          ),
          Divider(
            color: CommonColor.commonGreyColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: TextStyle(
                  color: CommonColor.mediumGreyColor,
                ),
              ),
              Text(
                "Rs.50",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              )
            ],
          ),
          Divider(
            color: CommonColor.commonGreyColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  color: CommonColor.mediumGreyColor,
                ),
              ),
              Text(
                "Rs.700",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.005,
          )
        ]),
      ),
    );
  }
}
