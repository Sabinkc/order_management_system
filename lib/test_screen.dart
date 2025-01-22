import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    List<String> categoryList = [
      "All",
      "Phone",
      "Laptop",
      "Camera",
    ];



    return ChangeNotifierProvider(
      create: (_) => TabBarProvider(), // Provide TabBarProvider
      child: Consumer<TabBarProvider>(
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

          return DefaultTabController(
            length: categoryList.length,
            initialIndex: tabBarProvider.selectedIndex,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: screenHeight * 0.9,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
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
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search products here...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    overlayColor: WidgetStateColor.transparent,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      tabBarProvider.selectTab(index);
                    },
                    tabs: categoryList
                        .map(
                          (tab) => Tab(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: tabBarProvider.selectedIndex ==
                                        categoryList.indexOf(tab)
                                    ? CommonColor.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(width: 1.5),
                              ),
                              child: Text(tab),
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
                        : GridView.builder(
                            itemCount: filteredProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        filteredProducts[index]["image"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      filteredProducts[index]["name"],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
