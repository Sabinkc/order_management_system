import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_management_system/common/common_color.dart';

class OrderHistoryTrackorderWidget extends StatelessWidget {
  OrderHistoryTrackorderWidget({super.key});

  final List<Map<String, dynamic>> steps = [
    {
      "title": "Order Placed",
      "subtitle": "Your Order has been received on 04-Feb-2025",
      "isActive": true,
      "image": "assets/icons/order_placed.svg"
    },
    {
      "title": "Order Confirmed",
      "subtitle": "Your Order has been confirmed on 04-Feb-2025",
      "isActive": true,
      "image": "assets/icons/order_confirmed.svg"
    },
    // {
    //   "title": "Order Processed",
    //   "subtitle": "We are preparing your order",
    //   "isActive": true,
    //   "image": "assets/icons/order_processed.svg"
    // },
    {
      "title": "Ready to Ship",
      "subtitle": "Your order is ready for shipping",
      "isActive": false,
      "image": "assets/icons/ready_to_ship.svg"
    },
    // {
    //   "title": "Out for Delivery",
    //   "subtitle": "Your order is Out for Delivery",
    //   "isActive": false,
    //   "image": "assets/icons/out_for_delivery.svg"
    // },
    {
      "title": "Delivered",
      "subtitle": "Your order is Delivered",
      "isActive": false,
      "image": "assets/icons/delivered.svg"
    },
  ];

  // int getLastActiveIndex(List<Map<String, dynamic>> steps) {
  //   for (int i = steps.length - 1; i >= 0; i--) {
  //     if (steps[i]["isActive"] == true) {
  //       return i; // Return the index of the last active step
  //     }
  //   }
  //   return -1; // Return -1 if no active step is found
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // int lastActiveIndex = getLastActiveIndex(steps);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Track Order",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CommonColor.darkGreyColor,
            ),
          ),
          SizedBox(height: 20),

          // Wrap ListView in a SizedBox with fixed height
          SizedBox(
            height: screenHeight * 0.4, // Adjust height as needed
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                bool isActive = steps[index]["isActive"];

                return SizedBox(
                  height: 80,
                  child: Stack(
                    children: [
                      // For the first step, draw only the lower half of the line
                      if (index == 0)
                        Positioned(
                          left: 5.5,
                          bottom: 0,
                          top: 37, // Line should be drawn below the circle
                          child: Container(
                            width: 5,
                            height:
                                25, // Half height for the first step (below the circle)
                            color: isActive
                                ? CommonColor.primaryColor
                                : Colors.grey,
                          ),
                        ),
                      // For the last step, draw only the upper half of the line
                      if (index == steps.length - 1)
                        Positioned(
                          left: 5.5,
                          top: 0,
                          bottom: 35, // Line should be drawn above the circle
                          child: Container(
                            width: 5,
                            height:
                                25, // Half height for the last step (above the circle)
                            color: isActive
                                ? CommonColor.primaryColor
                                : Colors.grey,
                          ),
                        ),

                      // if (index == lastActiveIndex)
                      //   Positioned(
                      //     left: 5.5,
                      //     top: 0,
                      //     bottom: 0,
                      //     child: Container(
                      //       width: 5,
                      //       height: 55, // Full height for the intermediate steps
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // For all the other steps, draw the full line
                      if (index != 0 && index != steps.length - 1)
                        Positioned(
                          left: 5.5,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 5,
                            height:
                                55, // Full height for the intermediate steps
                            color: isActive
                                ? CommonColor.primaryColor
                                : Colors.grey,
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Circular step indicator (Green for active, grey for others)
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? CommonColor.primaryColor
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // IconButton.outlined(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //         color: CommonColor.primaryColor, Icons.list)),

                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive
                                    ? CommonColor.primaryColor
                                    : Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: SvgPicture.asset(
                                    steps[index]["image"],
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        isActive
                                            ? Colors.white
                                            : CommonColor.darkGreyColor,
                                        BlendMode.srcIn),
                                  ),
                                ),
                              )),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  steps[index]["title"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CommonColor.darkGreyColor,
                                  ),
                                ),
                                Text(
                                  steps[index]["subtitle"],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: CommonColor.mediumGreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
