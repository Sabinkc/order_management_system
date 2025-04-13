import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/data/offers_model.dart';

class AllOffersScreen extends StatelessWidget {
  const AllOffersScreen({super.key});

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
                text: "All Offers",
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.80,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10),
            scrollDirection: Axis.vertical,
            itemCount: OffersModel.offers.length,
            itemBuilder: (context, index) {
              return Container(
                width: 170,
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
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  OffersModel.offers[index]["discount"],
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
              );
            }),
      ),
    );
  }
}
