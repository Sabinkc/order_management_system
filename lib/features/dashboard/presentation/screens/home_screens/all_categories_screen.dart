import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_api_sevice.dart';
import 'package:order_management_system/features/dashboard/domain/product_provider.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/category_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllCategoriesScreen extends StatelessWidget {
  AllCategoriesScreen({super.key});

  final productApiService = ProductApiSevice();

  @override
  Widget build(BuildContext context) {
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
                                                index],
                                            index: productProvider
                                                .productCategoryWithoutAll[
                                                    index]
                                                .id,
                                          )));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                // height: 90,
                                height: 80,
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
                                  borderRadius: BorderRadius.circular(50),
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
                                  borderRadius: BorderRadius.circular(50),
                                  child: FutureBuilder(
                                      future: productApiService
                                          .getCategoryImage(productProvider
                                              .productCategoryWithoutAll[index]
                                              .categoryImage),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                            cacheHeight: 120,
                                            cacheWidth: 120,
                                          );
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[100]!,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                color: Colors.white,
                                              ));
                                        } else {
                                          return Icon(Icons.broken_image);
                                        }
                                      }),
                                ),
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
