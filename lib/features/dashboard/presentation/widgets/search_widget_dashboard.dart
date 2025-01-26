import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/test_screen.dart';


class SearchWidgetDashboard extends StatelessWidget {
  const SearchWidgetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
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
    );
  }
}
