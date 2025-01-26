// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/test_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return KeyboardDismisser(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: RichText(
//               text: TextSpan(children: [
//             TextSpan(
//               text: "Order",
//               style: TextStyle(
//                   fontSize: 22,
//                   color: CommonColor.primaryColor,
//                   fontWeight: FontWeight.bold),
//             ),
//             TextSpan(
//               text: "Management",
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//           ])),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(
//               Icons.menu,
//             ),
//             onPressed: () {},
//           ),
//           actions: [
//             const SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // SizedBox(
//               //   height: screenHeight * 0.06,
//               // ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: CommonColor.primaryColor),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               spacing: 78,
//                               children: [
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.all(4),
//                                         child: Icon(
//                                           Icons.location_on,
//                                           color: CommonColor.primaryColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Kathmandu",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(
//                                   "(977 987654321)",
//                                   style: TextStyle(
//                                       color: CommonColor.darkGreyColor,
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             Padding(
//                                 padding: EdgeInsets.only(left: 32),
//                                 child: Text(
//                                   "P7PW-664, Kathmandu 44600",
//                                   style: TextStyle(
//                                       color: CommonColor.darkGreyColor,
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.bold),
//                                 ))
//                           ],
//                         ),
//                         Icon(
//                           Icons.keyboard_arrow_right_rounded,
//                           size: 24,
//                           color: CommonColor.primaryColor,
//                         ),
//                       ],
//                     )),
//               ),
//               SizedBox(
//                 height: screenWidth * 0.05,
//               ),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     "Orders",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   )),
//               SizedBox(
//                 height: screenWidth * 0.02,
//               ),
//               Divider(),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   height: screenHeight * 0.33,
//                   child: ListView.builder(
//                       itemCount: 4,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 5),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5),
//                                 child: Container(
//                                   // padding: EdgeInsets.all(5),
//                                   height: screenHeight * 0.15,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(8),
//                                     // boxShadow: [
//                                     //   BoxShadow(
//                                     //       color: Colors.grey,
//                                     //       offset: Offset(0.2, 0.2),
//                                     //       blurRadius: 5)
//                                     // ],
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[100],
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         height: 150,
//                                         width: 100,
//                                         child: Image.asset(
//                                           "assets/images/sprite.png",
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 15),
//                                         child: Container(
//                                           width: 170,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                                 "Sprite Lemon-Lime Flavour",
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "Rs.",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: CommonColor
//                                                             .primaryColor,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     "300",
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: CommonColor
//                                                             .primaryColor,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 7,
//                                                   ),
//                                                   Text(
//                                                     "Cold Drinks",
//                                                     style: TextStyle(
//                                                         fontSize: 11,
//                                                         color: CommonColor
//                                                             .mediumGreyColor,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     height: 25,
//                                                     width: 25,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topLeft: Radius
//                                                                   .circular(3),
//                                                               bottomLeft: Radius
//                                                                   .circular(3)),
//                                                       border: Border.all(
//                                                           color: CommonColor
//                                                               .mediumGreyColor),
//                                                     ),
//                                                     child: Center(
//                                                       child: Icon(
//                                                         size: 16,
//                                                         Icons.remove,
//                                                         color: CommonColor
//                                                             .primaryColor,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 25,
//                                                     width: 25,
//                                                     decoration: BoxDecoration(
//                                                       border: Border.symmetric(
//                                                           horizontal:
//                                                               BorderSide(
//                                                         color: CommonColor
//                                                             .mediumGreyColor,
//                                                       )),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "1",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 16,
//                                                             color: CommonColor
//                                                                 .primaryColor),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 25,
//                                                     width: 25,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topRight: Radius
//                                                                   .circular(3),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           3)),
//                                                       border: Border.all(
//                                                           color: CommonColor
//                                                               .mediumGreyColor),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.add,
//                                                       size: 16,
//                                                       color: CommonColor
//                                                           .primaryColor,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                             size: 18,
//                                             MingCute.delete_2_fill,
//                                             color: CommonColor.primaryColor,
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       }),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Divider(),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     "Invoice Details:",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   )),
//               SizedBox(
//                 height: screenHeight * 0.015,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   spacing: 15,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total Amount:",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 "Rs.",
//                                 style: TextStyle(
//                                   color: CommonColor.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 "1000",
//                                 style: TextStyle(
//                                   color: CommonColor.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total Quantity:",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 "(4)",
//                                 style: TextStyle(
//                                   color: CommonColor.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),

//               Divider(),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "Total Price:",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 12),
//                         ),
//                         RichText(
//                             text: TextSpan(children: [
//                           TextSpan(
//                             text: "Rs.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: CommonColor.primaryColor),
//                           ),
//                           TextSpan(
//                             text: "1699",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: CommonColor.primaryColor),
//                           ),
//                         ])),
//                       ],
//                     ),
//                     SizedBox(
//                       width: screenWidth * 0.35,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             backgroundColor: Color(0xFF100045),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             "Check Out",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               Divider(),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                           isScrollControlled: true,
//                           useSafeArea: true,
//                           context: context,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(50),
//                                   topRight: Radius.circular(50))),
//                           builder: (context) {
//                             return TestScreen();
//                           },
//                         );
//                       },
//                       child: Container(
//                         width: screenWidth * 0.75,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Row(
//                           spacing: 10,
//                           children: [
//                             SizedBox(
//                               width: 7,
//                             ),
//                             Icon(
//                               Icons.search,
//                               color: CommonColor.primaryColor,
//                             ),
//                             Text(
//                               "Search products here...",
//                               style: TextStyle(color: Colors.grey),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.grey[200],
//                       // foregroundColor: CommonColor.primaryColor,
//                       // backgroundColor: CommonColor.primaryColor,
//                       child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.person,
//                             size: 35,
//                             color: Colors.grey,
//                           )),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/test_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Order",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "Management",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {},
          ),
          actions: [
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: screenHeight * 0.06,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CommonColor.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 78,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.location_on,
                                          color: CommonColor.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Kathmandu",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "(977 987654321)",
                                  style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 32),
                                child: Text(
                                  "P7PW-664, Kathmandu 44600",
                                  style: TextStyle(
                                      color: CommonColor.darkGreyColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 24,
                          color: CommonColor.primaryColor,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Orders",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              SizedBox(
                height: screenWidth * 0.02,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: screenHeight * 0.33,
                  child: Consumer<CartQuantityProvider>(
                      builder: (context, provider, child) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          height: 150,
                                          width: 100,
                                          child: Image.asset(
                                            item.imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Container(
                                            width: 170,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  item.productName,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs.",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: CommonColor
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "300",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: CommonColor
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      "Cold Drinks",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: CommonColor
                                                              .mediumGreyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        3),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        3)),
                                                        border: Border.all(
                                                            color: CommonColor
                                                                .mediumGreyColor),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          size: 16,
                                                          Icons.remove,
                                                          color: CommonColor
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        border:
                                                            Border.symmetric(
                                                                horizontal:
                                                                    BorderSide(
                                                          color: CommonColor
                                                              .mediumGreyColor,
                                                        )),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "1",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        3),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            3)),
                                                        border: Border.all(
                                                            color: CommonColor
                                                                .mediumGreyColor),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 16,
                                                        color: CommonColor
                                                            .primaryColor,
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
                                              Provider.of<CartQuantityProvider>(
                                                      context,
                                                      listen: false)
                                                  .removeFromCart(provider
                                                      .cartItems[index].id);
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
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Invoice Details:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Rs.",
                                style: TextStyle(
                                  color: CommonColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "1000",
                                style: TextStyle(
                                  color: CommonColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Quantity:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "(4)",
                                style: TextStyle(
                                  color: CommonColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),

              Divider(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Price:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Rs.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CommonColor.primaryColor),
                          ),
                          TextSpan(
                            text: "1699",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CommonColor.primaryColor),
                          ),
                        ])),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Color(0xFF100045),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Divider(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          builder: (context) {
                            return TestScreen();
                          },
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.75,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          spacing: 10,
                          children: [
                            SizedBox(
                              width: 7,
                            ),
                            Icon(
                              Icons.search,
                              color: CommonColor.primaryColor,
                            ),
                            Text(
                              "Search products here...",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[200],
                      // foregroundColor: CommonColor.primaryColor,
                      // backgroundColor: CommonColor.primaryColor,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
