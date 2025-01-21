// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';

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
//     return DefaultTabController(
//       length: 4,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//         height: screenHeight * 0.9,
//         decoration: BoxDecoration(),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       hintText: "Search products here...",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                   ),
//                 ),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TabBar(
//               dividerColor: Colors.transparent,
//               indicatorColor: Colors.transparent,
//               padding: EdgeInsets.zero,
//               labelPadding: EdgeInsets.zero,
//               labelColor: Colors.white,
//               overlayColor: WidgetStateColor.transparent,
//               isScrollable: true,
//               tabAlignment: TabAlignment.start,
//               tabs: categoryList
//                   .map(
//                     (tab) => Tab(
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10),
//                         padding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         decoration: BoxDecoration(
//                           color: CommonColor.primaryColor,
//                           borderRadius: BorderRadius.circular(18),
//                           border: Border.all(width: 1.5),
//                         ),
//                         child: Text(tab),
//                       ),
//                     ),
//                   )
//                   .toList(),
//               // tabs: [
//               //   Tab(
//               //     text: categoryList[0],
//               //   ),
//               //   Tab(
//               //     text: categoryList[1],
//               //   ),
//               //   Tab(
//               //     text: categoryList[2],
//               //   ),
//               //   Tab(
//               //     text: categoryList[3],
//               //   ),
//               // ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/tab_bar_provider.dart';
import 'package:provider/provider.dart'; // Import provider package

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          Color selectedTabColor =
              CommonColor.primaryColor; // Set selected tab color to red

          return DefaultTabController(
            length: 4,
            initialIndex: tabBarProvider
                .selectedIndex, // Set the initial index of the tab
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: screenHeight * 0.9,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search products here...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                      tabBarProvider.selectTab(
                          index); // Update selected tab index in provider
                    },
                    tabs: categoryList
                        .map(
                          (tab) => Tab(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: tabBarProvider.selectedIndex ==
                                        categoryList.indexOf(tab)
                                    ? selectedTabColor // Set color to red for the selected tab
                                    : Colors.white, // Default tab color
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(width: 1.5),
                              ),
                              child: Text(tab),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  // Display the text corresponding to the selected tab
                  // Text(
                  //   "Selected Category: ${categoryList[tabBarProvider.selectedIndex]}",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey,
                            child: Column(children: [
                              Image.asset("assets/images/camera.png"),
                              Text("Camera"),
                            ],)
                          );
                        }),
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
