// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/dashboard/presentation/screens/search_screen.dart';

// class SearchWidgetDashboard extends StatelessWidget {
//   const SearchWidgetDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final double screenWidth = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             useSafeArea: true,
//             context: context,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25))),
//             builder: (context) {
//               return SearchScreen();
//             },
//           );
//         },
//         child: Container(
//           // width: screenWidth * 0.75,
//           width: double.infinity,
//           height: 50,
//           decoration: BoxDecoration(
//               color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
//           child: Row(
//             spacing: 10,
//             children: [
//               SizedBox(
//                 width: 7,
//               ),
//               Icon(
//                 Icons.search,
//                 color: CommonColor.primaryColor,
//               ),
//               Text(
//                 "Search products here...",
//                 style: TextStyle(color: Colors.grey),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/search_screen.dart';

class SearchWidgetDashboard extends StatelessWidget {
  const SearchWidgetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (context) {
              return SearchScreen();
            },
          );
        },
        child: Container(
          // width: screenWidth * 0.75,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
    );
  }
}
