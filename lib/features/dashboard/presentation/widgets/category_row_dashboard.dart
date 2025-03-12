import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_detail_screen.dart';
import 'package:provider/provider.dart';

class CategoryRowDashboard extends StatelessWidget {
  const CategoryRowDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  color: CommonColor.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CommonColor.primaryColor),
              )
            ],
          ),
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 70,
                child: productProvider.isCategoryWithoutallLoading == true
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: CommonColor.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            productProvider.productCategoryWithoutAll.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryDetailScreen(
                                                category: productProvider
                                                    .productCategoryWithoutAll[
                                                        index]
                                                    .name,
                                              )));
                                },
                                child: Container(
                                  // height: 90,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CommonColor.primaryColor),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                    productProvider
                                        .productCategoryWithoutAll[index].name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: CommonColor.darkGreyColor,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  // child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(50),
                                  //     child: Image.asset(
                                  //       "assets/images/book.jpeg",
                                  //       fit: BoxFit.cover,
                                  //     )),
                                )),
                          );
                        }),
              ),
            );
          })
        ],
      ),
    );
  }
}
