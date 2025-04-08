import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/all_offers_screen.dart';

class OfferWidget extends StatelessWidget {
  OfferWidget({super.key});

  final List<Map> offersList = [
    {
      "offerTitle": "20% off on every wearing products!",
      "image": "assets/images/tshirt.jpeg"
    },
    {
      "offerTitle": "50% off on every electronic products!",
      "image": "assets/images/laptopcharger.jpeg"
    },
    {
      "offerTitle": "10% off on every sport products!",
      "image": "assets/images/sport.jpeg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Offers",
                  style: TextStyle(
                    color: CommonColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                   onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllOffersScreen()));
                },
                  child: Text(
                    "See all",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CommonColor.primaryColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 170,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Container(
                          // height: 180,
                          width: screenWidth - 40,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 10,
                                      children: [
                                        Text(
                                          offersList[index]["offerTitle"],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: CommonColor.darkGreyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  CommonColor.primaryColor,
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Shop Now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(60),
                                          topLeft: Radius.circular(60)),
                                      border:
                                          Border.all(color: Colors.grey[100]!)),
                                  height: double.infinity,
                                  width: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(60),
                                        topLeft: Radius.circular(60)),
                                    child: Image.asset(
                                      offersList[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // child: Image.asset(
                                  //   "assets/images/laptopcharger.jpeg",
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
