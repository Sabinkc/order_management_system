import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/offers_model.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/home_screens/all_offers_screen.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
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
              height: 3,
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0XFFFAFAFA),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                ),
                                height: 130,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  child: Image.asset(
                                    OffersModel.offers[index]["image"],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      OffersModel.offers[index]["product"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        OffersModel.offers[index]["category"],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: CommonColor.mediumGreyColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Row(children: [
                                        Text(
                                          OffersModel.offers[index]["price"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CommonColor.primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            OffersModel.offers[index]
                                                ["discount"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    // const SizedBox(width: 8),
                                    Icon(
                                      MingCute.shopping_cart_1_line,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
