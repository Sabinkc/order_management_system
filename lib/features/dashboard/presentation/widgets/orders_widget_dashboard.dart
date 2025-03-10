import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

class OrdersWidgetDashboard extends StatelessWidget {
  const OrdersWidgetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: screenHeight * 0.48,
        child:
            Consumer<CartQuantityProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.cartItems.length,
              itemBuilder: (context, index) {
                final item = provider.cartItems[index];
                logger.log(
                    "imageUrl: ${Constants.imageStorageBaseUrl}/${item.imagePath}");
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: screenHeight * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "${Constants.imageStorageBaseUrl}/${item.imagePath}",
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: SizedBox(
                                  width: 170,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        item.productName,
                                        style: TextStyle(
                                            fontSize: 16,
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
                                            item.price.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: CommonColor.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            item.category,
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
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<CartQuantityProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateQuantity(
                                                      item.id.toString(), -1);
                                            },
                                            child: Container(
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
                                                  color:
                                                      CommonColor.primaryColor,
                                                ),
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
                                                item.quantity.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: CommonColor
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<CartQuantityProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateQuantity(
                                                      item.id.toString(), 1);
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(3),
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    deleteItem(context, provider, index);
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

//logical part
//function to delete item
  deleteItem(BuildContext context, CartQuantityProvider provider, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              titlePadding: EdgeInsets.only(
                top: 12,
                bottom: 10,
              ),
              contentPadding: EdgeInsets.only(bottom: 12),
              title: Text(
                "Confirm to delete?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Are you sure you want to delete this item from cart?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: CommonColor.darkGreyColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: CommonColor.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: CommonColor.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: CommonColor.primaryColor,
                            ),
                            onPressed: () {
                              Provider.of<CartQuantityProvider>(context,
                                      listen: false)
                                  .removeFromCart(
                                      provider.cartItems[index].id.toString());
                              Navigator.pop(context);

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 1), () {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    });
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Center(
                                        child: Text(
                                          "Item deleted successfully!",
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor,
                                              fontSize: 14),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
