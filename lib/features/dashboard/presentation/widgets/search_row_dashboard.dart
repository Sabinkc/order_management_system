import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_product_detail_screen.dart.dart';
import 'package:order_management_system/features/dashboard/presentation/widgets/search_widget_dashboard.dart';

class SearchRowDashboard extends StatelessWidget {
  const SearchRowDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: screenWidth * 0.73, child: SearchWidgetDashboard()),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ProductDetailScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              height: 50,
              width: 50,
              child: Icon(
                Icons.filter_list,
                color: CommonColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
