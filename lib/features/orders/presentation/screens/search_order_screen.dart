import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/orders/domain/order_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchOrderScreen extends StatefulWidget {
  const SearchOrderScreen({super.key});

  @override
  State<SearchOrderScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchOrderScreen> {
  final TextEditingController searchController = TextEditingController();
  final productApiService = ProductApiSevice();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }
      final orderProvider =
          Provider.of<OrderScreenProvider>(context, listen: false);
      orderProvider.clearSearchedOrder();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    final orderProvider =
        Provider.of<OrderScreenProvider>(context, listen: false);
    orderProvider.clearSearchedOrder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Search Orders",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                )),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Consumer<OrderScreenProvider>(
              builder: (context, orderProvider, children) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        orderProvider
                            .fetchOrderByorderKey(searchController.text.trim());
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search order no...",
                        hintStyle: TextStyle(
                            color: CommonColor.darkGreyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        prefixIcon: InkWell(
                          onTap: () {
                            orderProvider.fetchOrderByorderKey(
                                searchController.text.trim());
                          },
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: CommonColor.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.grey[100]!), // Transparent border
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
                              color:
                                  Colors.grey[100]!), // Disabled border color
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //     onTap: () async {},
                  //     child: Padding(
                  //       padding: EdgeInsets.only(right: 8),
                  //       child: Text(
                  //         "Clear search",
                  //         style: TextStyle(
                  //             color: CommonColor.primaryColor,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     )),
                  Divider(
                    color: CommonColor.commonGreyColor,
                    thickness: 2,
                  ),
                  orderProvider.isFetchOrderByLoading == true
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: CommonColor.primaryColor,
                            ),
                          ),
                        )
                      : orderProvider.searchedOrder.isEmpty
                          ? Center(
                              child: Text(
                                "No orders matching with the orderKey!",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor,
                                    fontSize: 16),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Orders",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.005,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: SizedBox(
                                    height: 350,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        final order =
                                            orderProvider.searchedOrder[0];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: order.products
                                                  .map<Widget>((item) {
                                                return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 90,
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              // child:
                                                              //     Image.network(
                                                              //   "${Constants.imageStorageBaseUrl}/${item.imagePath}",
                                                              //   fit: BoxFit
                                                              //       .cover,
                                                              //   errorBuilder: (context,
                                                              //           error,
                                                              //           stackTrace) =>
                                                              //       Icon(Icons
                                                              //           .broken_image),
                                                              // ),
                                                              child:
                                                                  FutureBuilder(
                                                                      future: productApiService
                                                                          .getThumbnailByFilename(item
                                                                              .imagePath),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Image
                                                                              .memory(
                                                                            snapshot.data!,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            cacheHeight:
                                                                                120,
                                                                            cacheWidth:
                                                                                120,
                                                                          );
                                                                        } else if (snapshot.connectionState ==
                                                                            ConnectionState.waiting) {
                                                                          return Shimmer.fromColors(
                                                                              baseColor: Colors.grey[100]!,
                                                                              highlightColor: Colors.white,
                                                                              child: Container(
                                                                                color: Colors.white,
                                                                              ));
                                                                        } else {
                                                                          return Icon(
                                                                              Icons.broken_image);
                                                                        }
                                                                      }),
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 220,
                                                                child: Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  item.name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "${item.category} | Qty: ${item.quantity}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: CommonColor
                                                                        .mediumGreyColor),
                                                              ),
                                                              RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "Rs.",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              CommonColor.primaryColor),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "${item.price * item.quantity}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              21,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              CommonColor.primaryColor),
                                                                    ),
                                                                  ])),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              }).toList(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Divider(
                                    color: CommonColor.commonGreyColor,
                                    thickness: 2,
                                  ),
                                ),
                                // Spacer(),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Order Details:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order Date:",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                orderProvider
                                                    .searchedOrder[0].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order Status:",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                orderProvider
                                                    .searchedOrder[0].status
                                                    .toString(),
                                                style: TextStyle(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Quantity:",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                orderProvider.searchedOrder[0]
                                                    .totalQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Amount:",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Rs.",
                                                style: TextStyle(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                orderProvider.searchedOrder[0]
                                                    .totalAmount,
                                                style: TextStyle(
                                                  color:
                                                      CommonColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
            );
          })),
    );
  }
}
