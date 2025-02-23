// import 'package:flutter/material.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/data/product_model.dart';
// import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
// import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   late FocusNode _searchFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     _searchFocusNode = FocusNode();
//     // Automatically focus the search field when the screen is loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_searchFocusNode.canRequestFocus) {
//         _searchFocusNode.requestFocus();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     List<String> categoryList = [
//       "All",
//       "Cold Drink",
//       "Cosmetic",
//       "Diary & Milk",
//       "Vitamin"
//     ];

//     return Consumer<TabBarProvider>(
//       builder: (context, tabBarProvider, _) {
//         // Determine the selected category
//         String selectedCategory = categoryList[tabBarProvider.selectedIndex];

//         // Get the search keyword from the controller
//         String searchKeyword =
//             tabBarProvider.searchController.text.toLowerCase();

//         // Filter products based on the selected category and search keyword
//         List filteredProducts = selectedCategory == "All"
//             ? products.where((product) {
//                 return product["name"].toLowerCase().contains(searchKeyword);
//               }).toList()
//             : products
//                 .where((product) =>
//                     product["category"].toLowerCase() ==
//                         selectedCategory.toLowerCase() &&
//                     product["name"].toLowerCase().contains(searchKeyword))
//                 .toList();

//         return KeyboardDismisser(
//           child: DefaultTabController(
//             length: categoryList.length,
//             initialIndex: tabBarProvider.selectedIndex,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: CommonColor.commonGreyColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25))),
//               height: screenHeight * 0.7,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.01,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(
//                           Icons.cancel,
//                           color: Colors.transparent,
//                         ),
//                         Center(
//                           child: Text(
//                             "Product Catlog",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w800, fontSize: 20),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: CommonColor.primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: TextFormField(
//                       controller: tabBarProvider.searchController,
//                       focusNode: _searchFocusNode, // Assign the FocusNode
//                       autofocus: true, // Automatically focus the field
//                       onChanged: (value) {
//                         Provider.of<TabBarProvider>(context, listen: false)
//                             .updateSearchKeyword(value);
//                       },
//                       onFieldSubmitted: (value) {
//                         Provider.of<TabBarProvider>(context, listen: false)
//                             .updateSearchKeyword(value);
//                       },
//                       decoration: InputDecoration(
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: "What are you looking for?",
//                         hintStyle: TextStyle(
//                             color: CommonColor.darkGreyColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           size: 23,
//                           color: CommonColor.primaryColor,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: Colors.transparent), // Transparent border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: CommonColor.primaryColor,
//                               width: 2), // Focused border color
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: Colors.red,
//                               width: 2), // Error border color
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: Colors.red,
//                               width: 2), // Focused error border color
//                         ),
//                         disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: Colors.grey), // Disabled border color
//                         ),
//                       ),
//                     ),
//                   ),
//                   TabBar(
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     unselectedLabelColor: CommonColor.darkGreyColor,
//                     indicatorColor: CommonColor.primaryColor,
//                     labelColor: CommonColor.primaryColor,
//                     labelPadding: EdgeInsets.symmetric(horizontal: 25),
//                     isScrollable: true,
//                     tabAlignment: TabAlignment.start,
//                     onTap: (index) {
//                       tabBarProvider.selectTab(index);
//                     },
//                     tabs: categoryList
//                         .map(
//                           (tab) => Tab(
//                             child: Text(
//                               tab,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 17),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: filteredProducts.isEmpty
//                         ? Center(
//                             child: Text(
//                               "No products found",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           )
//                         : Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 20,
//                             ),
//                             child: GridView.builder(
//                               itemCount: filteredProducts.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 childAspectRatio: 0.75,
//                                 crossAxisCount: 2,
//                                 mainAxisSpacing: 10,
//                                 crossAxisSpacing: 10,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return Consumer<CartQuantityProvider>(
//                                     builder: (context, provider, child) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             Future.delayed(Duration(seconds: 1),
//                                                 () {
//                                               if (context.mounted) {
//                                                 Navigator.pop(context);
//                                               }
//                                             });
//                                             return AlertDialog(
//                                               backgroundColor: Colors.white,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           15)),
//                                               title: Center(
//                                                 child: Text(
//                                                   "Item added to cart successfully!",
//                                                   style: TextStyle(
//                                                       color: CommonColor
//                                                           .darkGreyColor,
//                                                       fontSize: 14),
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                       Provider.of<CartQuantityProvider>(context,
//                                               listen: false)
//                                           .addToCart(filteredProducts[index]
//                                               ["product_id"]);
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Colors.white),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Color(0XFFFAFAFA),
//                                                 borderRadius:
//                                                     BorderRadius.vertical(
//                                                         top: Radius.circular(
//                                                             8))),
//                                             height: 130,
//                                             width: double.infinity,
//                                             child: Image.asset(
//                                               filteredProducts[index]["image"],
//                                               fit: BoxFit.contain,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 15),
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 8),
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               maxLines: 2,
//                                               filteredProducts[index]["name"],
//                                               textAlign: TextAlign.start,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 7,
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 8),
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   "Rs.",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: CommonColor
//                                                           .primaryColor,
//                                                       fontSize: 12),
//                                                 ),
//                                                 Text(
//                                                   filteredProducts[index]
//                                                           ["price"]
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: CommonColor
//                                                           .primaryColor),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 8,
//                                                 ),
//                                                 Text(
//                                                   filteredProducts[index]
//                                                           ["category"]
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 11,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: CommonColor
//                                                           .mediumGreyColor),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 });
//                               },
//                             ),
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FocusNode _searchFocusNode;

  // @override
  // void initState() {
  //   super.initState();
  //   _searchFocusNode = FocusNode();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (_searchFocusNode.canRequestFocus) {
  //       _searchFocusNode.requestFocus();
  //     }
  //   });
  //   Provider.of<ProductProvider>(context, listen: false)
  //       .getAllProductCategories();
  //           Provider.of<ProductProvider>(context, listen: false)
  //       .getCategoryProducts(1);
  // }

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_searchFocusNode.canRequestFocus) {
        _searchFocusNode.requestFocus();
      }

      Future.delayed(Duration.zero, () {
        if (!mounted) {
          return;
        }
        Provider.of<ProductProvider>(context, listen: false)
            .getAllProductCategories();
        Provider.of<ProductProvider>(context, listen: false)
            .getCategoryProducts(1);
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<TabBarProvider>(
      builder: (context, tabBarProvider, _) {
        return KeyboardDismisser(
          child: DefaultTabController(
            length: productProvider.productCategory.length,
            initialIndex: tabBarProvider.selectedIndex,
            child: Container(
              decoration: BoxDecoration(
                color: CommonColor.commonGreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              height: screenHeight * 0.7,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.cancel, color: Colors.transparent),
                        const Center(
                          child: Text(
                            "Product Catalog",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: CommonColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: tabBarProvider.searchController,
                      focusNode: _searchFocusNode,
                      autofocus: true,
                      onChanged: (value) {
                        tabBarProvider.updateSearchKeyword(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "What are you looking for?",
                        hintStyle: TextStyle(
                          color: CommonColor.darkGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 23,
                          color: CommonColor.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: CommonColor.primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  productProvider.isCategoryLoading
                      ? CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        )
                      : TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: CommonColor.darkGreyColor,
                          indicatorColor: CommonColor.primaryColor,
                          labelColor: CommonColor.primaryColor,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          onTap: (index) {
                            tabBarProvider.selectTab(index);
                          },
                          tabs: productProvider.productCategory
                              .map(
                                (tab) => Tab(
                                  child: Text(
                                    tab.name, // Accessing the 'name' property of ProductCategory
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: productProvider.categoryProducts.isEmpty
                        ? Center(
                            child: Text(
                              "No products found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.builder(
                              itemCount: productProvider.categoryProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.75,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Consumer<CartQuantityProvider>(
                                  builder: (context, provider, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            });
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              title: Center(
                                                child: Text(
                                                  "Item added to cart successfully!",
                                                  style: TextStyle(
                                                      color: CommonColor
                                                          .darkGreyColor,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0XFFFAFAFA),
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                  top: Radius.circular(8),
                                                ),
                                              ),
                                              height: 130,
                                              width: double.infinity,
                                              child: Image.asset(
                                                "assets/images/sprite.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child:  Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                "${productProvider.categoryProducts[index]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Rs. 300",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Drinks",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .mediumGreyColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
