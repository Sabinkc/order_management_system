import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Ord",
              style: TextStyle(
                  fontSize: 22,
                  color: CommonColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "ers",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ])),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order History",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: CommonColor.mediumGreyColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: CommonColor.mediumGreyColor,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "12/09/2024",
                style: TextStyle(
                    color: CommonColor.mediumGreyColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#ABC23RC",
                    style: TextStyle(
                        color: CommonColor.darkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: CommonColor.mediumGreyColor,
                          color: CommonColor.mediumGreyColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: CommonColor.mediumGreyColor,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 80,
                            width: 110,
                            color: Colors.grey[100],
                            child: Image.asset(
                              "assets/images/cetaphil.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cetaphil-100 pieces, 200 mg",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CommonColor.mediumGreyColor),
                            ),
                            Text(
                              "Quantity: 1 | Rs. 300",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: CommonColor.mediumGreyColor),
                            )
                          ],
                        )
                      ],
                    );
                  }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Divider(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "12/09/2023",
                style: TextStyle(
                    color: CommonColor.mediumGreyColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#XYZ24DR",
                    style: TextStyle(
                        color: CommonColor.darkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: CommonColor.mediumGreyColor,
                          color: CommonColor.mediumGreyColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: CommonColor.mediumGreyColor,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 80,
                            width: 110,
                            color: Colors.grey[100],
                            child: Image.asset(
                              "assets/images/amulcheese.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amulcheese-100 pieces, 200 mg",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CommonColor.mediumGreyColor),
                            ),
                            Text(
                              "Quantity: 2 | Rs. 400",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: CommonColor.mediumGreyColor),
                            )
                          ],
                        )
                      ],
                    );
                  }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#XYZ24DB",
                    style: TextStyle(
                        color: CommonColor.darkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: CommonColor.mediumGreyColor,
                          color: CommonColor.mediumGreyColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: CommonColor.mediumGreyColor,
                      )
                    ],
                  )
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 80,
                            width: 110,
                            color: Colors.grey[100],
                            child: Image.asset(
                              "assets/images/sprite.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sprite lemon, 200 ml",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CommonColor.mediumGreyColor),
                            ),
                            Text(
                              "Quantity: 1 | Rs. 300",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: CommonColor.mediumGreyColor),
                            )
                          ],
                        )
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
