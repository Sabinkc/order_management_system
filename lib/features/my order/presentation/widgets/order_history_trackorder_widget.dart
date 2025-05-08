import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';
// import 'dart:developer' as logger;

class OrderHistoryTrackorderWidget extends StatelessWidget {
  OrderHistoryTrackorderWidget({super.key});

  // Define all possible order status steps
  final List<Map<String, dynamic>> allSteps = [
    {
      "status": "pending",
      "title": "Order Pending",
      "subtitle": "Your Order is pending.",
      "image": "assets/icons/order_placed.svg"
    },
    {
      "status": "confirmed",
      "title": "Order Confirmed",
      "subtitle": "Your Order has been confirmed.",
      "image": "assets/icons/order_confirmed.svg"
    },
    {
      "status": "shipped",
      "title": "Order Shipped",
      "subtitle": "Your order has been shipped.",
      "image": "assets/icons/ready_to_ship.svg"
    },
    {
      "status": "delivered",
      "title": "Delivered",
      "subtitle": "Your order is Delivered.",
      "image": "assets/icons/delivered.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<OrderScreenProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.ordersBySandD.isEmpty) {
          return const Center(child: Text("No orders available"));
        }

        final firstOrder = orderProvider.ordersBySandD[0];
        final currentStatus = firstOrder.status.toLowerCase();
        // logger.log("Current order status: $currentStatus");

        // Generate steps with proper active state based on current status
        final List<Map<String, dynamic>> steps = allSteps.map((step) {
          final stepStatus = step["status"].toString().toLowerCase();
          final isActive = _isStepActive(stepStatus, currentStatus);
          return {
            ...step,
            "isActive": isActive,
          };
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.trackOrder,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CommonColor.darkGreyColor,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: screenHeight * 0.38,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    final isActive = step["isActive"] as bool;

                    return SizedBox(
                      height: 80,
                      child: Stack(
                        children: [
                          // For the first step, draw only the lower half of the line
                          if (index == 0)
                            Positioned(
                              left: 5.5,
                              bottom: 0,
                              top: 37,
                              child: Container(
                                width: 5,
                                height: 25,
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
                              bottom: 35,
                              child: Container(
                                width: 5,
                                height: 25,
                                color: isActive
                                    ? CommonColor.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          // For intermediate steps
                          if (index != 0 && index != steps.length - 1)
                            Positioned(
                              left: 5.5,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 5,
                                height: 55,
                                color: isActive
                                    ? CommonColor.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Circular step indicator
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
                                      step["image"],
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        isActive
                                            ? Colors.white
                                            : CommonColor.darkGreyColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      step["title"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CommonColor.darkGreyColor,
                                      ),
                                    ),
                                    Text(
                                      step["subtitle"],
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
      },
    );
  }

  // Helper function to determine if a step should be active
  bool _isStepActive(String stepStatus, String currentStatus) {
    final statusOrder = allSteps.map((s) => s["status"].toString()).toList();
    final currentIndex = statusOrder.indexOf(currentStatus);
    final stepIndex = statusOrder.indexOf(stepStatus);

    // If we can't find the status, default to inactive
    if (currentIndex == -1 || stepIndex == -1) return false;

    return stepIndex <= currentIndex;
  }
}
