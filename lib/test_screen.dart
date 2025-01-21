// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/data/product_model.dart';
// import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
// import 'package:provider/provider.dart'; // Import provider package

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     List<String> categoryList = [
//       "All",
//       "Phone",
//       "Laptop",
//       "Camera",
//     ];

//     return ChangeNotifierProvider(
//       create: (_) => TabBarProvider(), // Provide TabBarProvider
//       child: Consumer<TabBarProvider>(
//         builder: (context, tabBarProvider, _) {
//           Color selectedTabColor =
//               CommonColor.primaryColor; // Set selected tab color to red

//           return DefaultTabController(
//             length: 4,
//             initialIndex: tabBarProvider
//                 .selectedIndex, // Set the initial index of the tab
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               height: screenHeight * 0.9,
//               decoration: BoxDecoration(),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.search),
//                             hintText: "Search products here...",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                           ),
//                         ),
//                       ),
//                       IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TabBar(
//                     dividerColor: Colors.transparent,
//                     indicatorColor: Colors.transparent,
//                     padding: EdgeInsets.zero,
//                     labelPadding: EdgeInsets.zero,
//                     labelColor: Colors.white,
//                     overlayColor: WidgetStateColor.transparent,
//                     isScrollable: true,
//                     tabAlignment: TabAlignment.start,
//                     onTap: (index) {
//                       tabBarProvider.selectTab(
//                           index); // Update selected tab index in provider
//                     },
//                     tabs: categoryList
//                         .map(
//                           (tab) => Tab(
//                             child: Container(
//                               margin: EdgeInsets.symmetric(horizontal: 10),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 15),
//                               decoration: BoxDecoration(
//                                 color: tabBarProvider.selectedIndex ==
//                                         categoryList.indexOf(tab)
//                                     ? selectedTabColor // Set color to red for the selected tab
//                                     : Colors.white, // Default tab color
//                                 borderRadius: BorderRadius.circular(18),
//                                 border: Border.all(width: 1.5),
//                               ),
//                               child: Text(tab),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                   SizedBox(height: 20),
//                   // Display the text corresponding to the selected tab
//                   // Text(
//                   //   "Selected Category: ${categoryList[tabBarProvider.selectedIndex]}",
//                   //   style: TextStyle(fontSize: 18),
//                   // ),
//                   Expanded(
//                     child: GridView.builder(
//                         itemCount: products.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 5,
//                           crossAxisSpacing: 5,
//                         ),
//                         itemBuilder: (context, index) {
//                           return Container(
//                               color: Colors.grey,
//                               child: Column(
//                                 children: [
//                                   Image.asset(products[index]["image"]),
//                                   Text(products[index]["category"]),
//                                 ],
//                               ));
//                         }),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart'; // Import provider package

// final List products = [
//   {
//     "product_id": "1",
//     "name": "Wireless Bluetooth Headphones",
//     "image": "assets/images/camera.png",
//     "description":
//         "High-quality wireless Bluetooth headphones with noise cancellation and long battery life.",
//     "price": 79.99,
//     "category": "camera"
//   },
//   {
//     "product_id": "2",
//     "name": "Smartwatch with Heart Rate Monitor",
//     "image": "assets/images/phone.png",
//     "description":
//         "A smartwatch that tracks your heart rate, steps, and provides notifications on the go.",
//     "price": 129.99,
//     "category": "phone"
//   },
//   {
//     "product_id": "3",
//     "name": "Portable Power Bank 10000mAh",
//     "image": "assets/images/laptop.png",
//     "description":
//         "A compact and powerful portable power bank to charge your devices on the go.",
//     "price": 29.99,
//     "category": "laptop"
//   },
//   {
//     "product_id": "4",
//     "name": "4K Ultra HD Smart TV",
//     "image": "assets/images/camera.png",
//     "description":
//         "A 55-inch 4K Ultra HD Smart TV with voice control and smart features.",
//     "price": 499.99,
//     "category": "camera"
//   },
//   {
//     "product_id": "5",
//     "name": "Wireless Bluetooth Headphones",
//     "image": "assets/images/phone.png",
//     "description":
//         "High-quality wireless Bluetooth headphones with noise cancellation and long battery life.",
//     "price": 79.99,
//     "category": "phone"
//   },
// ];

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

          // Filter products based on the selected category
          List filteredProducts = selectedCategory == "All"
              ? products
              : products
                  .where((product) =>
                      product["category"].toLowerCase() ==
                      selectedCategory.toLowerCase())
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search products here...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.cancel)),
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
                                    : Colors.white,
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
                    child: GridView.builder(
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
