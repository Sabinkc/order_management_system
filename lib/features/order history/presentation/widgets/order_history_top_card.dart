import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/order%20history/domain/order_history_provider.dart';
import 'package:order_management_system/features/order%20history/domain/switch_order_screen_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryTopCard extends StatelessWidget {
  const OrderHistoryTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final SwitchOrderScreenProvider switchOrderScreenProvider =
        Provider.of<SwitchOrderScreenProvider>(context);
    return Consumer<OrderHistoryProvider>(
      builder: (context, provider, child) {
        final order = provider.orders;
        final int lastOrderIndex = order.length - 1;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.29,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CommonColor.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order No: ${order[lastOrderIndex]["orderId"]}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Status: ${order[lastOrderIndex]["status"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${order[lastOrderIndex]["date"]}",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 90,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(
                              "${Constants.imageStorageBaseUrl}/${order[lastOrderIndex]["items"][0]
                                  .imagePath}", // First item image
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 220,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                order[lastOrderIndex]["items"][0]
                                    .productName, // First item name
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "${order[lastOrderIndex]["items"][0].category} | Qty: ${order[lastOrderIndex]["items"][0].quantity}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Rs.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${order[lastOrderIndex]["items"][0].price * order[lastOrderIndex]["items"][0].quantity}", // First item price
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    switchOrderScreenProvider.selectedIndex == 0
                                        ? Colors.blue
                                        : Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<SwitchOrderScreenProvider>(context,
                                    listen: false)
                                .switchSelectedIndex(0);
                          },
                          child: Text(
                            "Track Order",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    switchOrderScreenProvider.selectedIndex == 1
                                        ? Colors.blue
                                        : Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<SwitchOrderScreenProvider>(context,
                                    listen: false)
                                .switchSelectedIndex(1);
                          },
                          child: Text(
                            "View Invoice",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
