import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/simple_ui_provider.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:order_management_system/features/my%20order/domain/switch_order_screen_provider.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_invoice_widget.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_top_card.dart';
import 'package:order_management_system/features/my%20order/presentation/widgets/order_history_trackorder_widget.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';

class MyOrderHistoryScreen extends StatefulWidget {
  const MyOrderHistoryScreen({super.key});

  @override
  State<MyOrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<MyOrderHistoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderProvider.resetAllOrders();
      Provider.of<OrderScreenProvider>(context, listen: false);
      final simpleUiProvider =
          Provider.of<SimpleUiProvider>(context, listen: false);
      orderProvider.clearFilters();
      orderProvider.clearSearchKeyword();
      simpleUiProvider.clearDateRange();
      await orderProvider.getOrderByStatusAndDate("", "", "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.myOrders,
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
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        elevation: 0,
        edgeOffset: 2,
        color: CommonColor.primaryColor,
        onRefresh: () async {
          final orderProvider =
              Provider.of<OrderScreenProvider>(context, listen: false);
          orderProvider.resetAllOrders();
          final simpleUiProvider =
              Provider.of<SimpleUiProvider>(context, listen: false);
          await orderProvider.getOrderByStatusAndDate(
              simpleUiProvider.selectedStatus,
              simpleUiProvider.selectedStartDate,
              simpleUiProvider.selectedEndDate);
        },
        child: SafeArea(
          child: Consumer<OrderScreenProvider>(
            builder: (context, orderProvider, child) {
              if (orderProvider.isOrderBySandDLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: CommonColor.primaryColor,
                  ),
                );
              }
              if (orderProvider.ordersBySandD.isEmpty) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: screenHeight * 0.6,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MingCute.shopping_bag_1_line,
                          color: CommonColor.darkGreyColor,
                          weight: 0.5,
                          size: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "No orders till now!",
                          style: TextStyle(
                              color: CommonColor.darkGreyColor, fontSize: 20),
                        ),
                      ],
                    )),
                  ),
                );
              }

              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: screenHeight * 0.01,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: Text(
                    //     "My Orders",
                    //     style:
                    //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    OrderHistoryTopCard(),
                    Consumer<SwitchOrderScreenProvider>(
                        builder: (context, provider, child) {
                      return provider.selectedIndex == 0
                          ? OrderHistoryTrackorderWidget()
                          : OrderHistoryInvoiceWidget();
                    })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
