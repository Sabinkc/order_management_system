import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_detail_screen.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List categoryImages = [
      "assets/images/electronic_c.png",
      "assets/images/clothing_c.png",
      "assets/images/furniture_c.png",
      "assets/images/grocery_c.png",
      "assets/images/stationary_c.png",
      "assets/images/books_c.png",
      "assets/images/toys_c.png",
      "assets/images/sports_c.png",
      "assets/images/automobile_c.png"
    ];

    return Scaffold(
      backgroundColor: CommonColor.scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColor.primaryColor,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "All Categories",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GridView.builder(
              itemCount: productProvider.productCategoryWithoutAll.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        GestureDetector(
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
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                // height: 90,
                                height: 70,
                                width: 80,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                        color: Colors.grey),
                                    // BoxShadow(
                                    //     offset: Offset(-2, -2),
                                    //     blurRadius: 1,
                                    //     color: Colors.grey)
                                  ],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                // child: Center(
                                //     child: Text(
                                //   productProvider
                                //       .productCategoryWithoutAll[index].name,
                                //   style: TextStyle(
                                //       fontSize: 12,
                                //       color: CommonColor.darkGreyColor,
                                //       fontWeight: FontWeight.w600),
                                //   overflow: TextOverflow.ellipsis,
                                // )),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      categoryImages[index],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          productProvider.productCategoryWithoutAll[index].name,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 12,
                              color: CommonColor.darkGreyColor,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ));
              }),
        );
      }),
    );
  }
}
