import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:provider/provider.dart';

class OrdersWidgetDashboard extends StatelessWidget {
  const OrdersWidgetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: screenHeight * 0.33,
        child:
            Consumer<CartQuantityProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.cartItems.length,
              itemBuilder: (context, index) {
                final item = provider.cartItems[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          // padding: EdgeInsets.all(5),
                          height: screenHeight * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.grey,
                            //       offset: Offset(0.2, 0.2),
                            //       blurRadius: 5)
                            // ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 150,
                                width: 100,
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: SizedBox(
                                  width: 170,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        item.productName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Rs.",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "300",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            "Cold Drinks",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color:
                                                    CommonColor.mediumGreyColor,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(3),
                                                  bottomLeft:
                                                      Radius.circular(3)),
                                              border: Border.all(
                                                  color: CommonColor
                                                      .mediumGreyColor),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                size: 16,
                                                Icons.remove,
                                                color: CommonColor.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  horizontal: BorderSide(
                                                color:
                                                    CommonColor.mediumGreyColor,
                                              )),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(3),
                                                  bottomRight:
                                                      Radius.circular(3)),
                                              border: Border.all(
                                                  color: CommonColor
                                                      .mediumGreyColor),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 16,
                                              color: CommonColor.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Provider.of<CartQuantityProvider>(context,
                                            listen: false)
                                        .removeFromCart(
                                            provider.cartItems[index].id);
                                  },
                                  icon: Icon(
                                    size: 18,
                                    MingCute.delete_2_fill,
                                    color: CommonColor.primaryColor,
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
