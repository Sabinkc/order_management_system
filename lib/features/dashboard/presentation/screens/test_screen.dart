import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:order_management_system/features/dashboard/domain/cart_quantity_provider.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    List<String> categoryList = [
      "All",
      "Cold Drink",
      "Cosmetic",
      "Diary & Milk",
      "Vitamin"
    ];

    return Consumer<TabBarProvider>(
      builder: (context, tabBarProvider, _) {
        // Determine the selected category
        String selectedCategory = categoryList[tabBarProvider.selectedIndex];

        // Get the search keyword from the controller
        String searchKeyword =
            tabBarProvider.searchController.text.toLowerCase();

        // Filter products based on the selected category and search keyword
        List filteredProducts = selectedCategory == "All"
            ? products.where((product) {
                return product["name"].toLowerCase().contains(searchKeyword);
              }).toList()
            : products
                .where((product) =>
                    product["category"].toLowerCase() ==
                        selectedCategory.toLowerCase() &&
                    product["name"].toLowerCase().contains(searchKeyword))
                .toList();

        return KeyboardDismisser(
          child: DefaultTabController(
            length: categoryList.length,
            initialIndex: tabBarProvider.selectedIndex,
            child: Container(
              decoration: BoxDecoration(
                  color: CommonColor.commonGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: screenHeight * 0.9,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.transparent,
                        ),
                        Center(
                          child: Text(
                            "Product Catlog",
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
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: tabBarProvider.searchController,
                      onChanged: (value) {
                        Provider.of<TabBarProvider>(context, listen: false)
                            .updateSearchKeyword(value);
                      },
                      onFieldSubmitted: (value) {
                        Provider.of<TabBarProvider>(context, listen: false)
                            .updateSearchKeyword(value);
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "What are you looking for?",
                        hintStyle: TextStyle(
                            color: CommonColor.darkGreyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 23,
                          color: CommonColor.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.transparent), // Transparent border
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
                              color: Colors.grey), // Disabled border color
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: CommonColor.darkGreyColor,
                    indicatorColor: CommonColor.primaryColor,
                    labelColor: CommonColor.primaryColor,
                    labelPadding: EdgeInsets.symmetric(horizontal: 25),
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      tabBarProvider.selectTab(index);
                    },
                    tabs: categoryList
                        .map(
                          (tab) => Tab(
                            child: Text(
                              tab,
                              style: TextStyle(
                                  // color: CommonColor.darkGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: filteredProducts.isEmpty
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: GridView.builder(
                              itemCount: filteredProducts.length,
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
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            });
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                                          });
                                      Provider.of<CartQuantityProvider>(context,
                                              listen: false)
                                          .addToCart(filteredProducts[index]
                                              ["product_id"]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0XFFFAFAFA),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            8))),
                                            height: 130,
                                            width: double.infinity,
                                            child: Image.asset(
                                              filteredProducts[index]["image"],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              filteredProducts[index]["name"],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Rs.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .primaryColor,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  filteredProducts[index]
                                                          ["price"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .primaryColor),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  filteredProducts[index]
                                                          ["category"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColor
                                                          .mediumGreyColor),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
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
