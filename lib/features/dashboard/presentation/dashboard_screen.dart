import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Order",
              style: TextStyle(
                  color: CommonColor.primaryColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "Management",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: screenHeight * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Image.asset(
                      "assets/images/camera.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get your special sale upto 50%",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CommonColor.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5)),
                              onPressed: () {},
                              child: Text(
                                "Shop Now",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      height: 300,
                      width: 300,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              product["image"],
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                            Text(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                product["name"]),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
