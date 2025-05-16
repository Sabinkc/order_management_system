import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final settingProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await settingProvider.fetchFaq();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColor.scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: CommonColor.primaryColor,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.current.faqs,
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "We are here to help you with anything and every thing on this app.",
                style:
                    TextStyle(color: CommonColor.mediumGreyColor, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
                child: Consumer<SettingsProvider>(
                    builder: (context, settingProvider, child) {
                  return settingProvider.isFaqLoading == true &&
                          settingProvider.faqs.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        ))
                      : settingProvider.faqs.isEmpty
                          ? Center(child: Text("Faqs not availiable"))
                          : ListView.builder(
                              itemCount: settingProvider.faqs.length,
                              itemBuilder: (context, index) {
                                final faq = settingProvider.faqs[index];
                                return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          iconColor: Colors.red[300],
                                          collapsedIconColor:
                                              CommonColor.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          collapsedShape:
                                              RoundedRectangleBorder(
                                            side: BorderSide.none,
                                          ),
                                          title: Text(
                                            "${faq.id}. ${faq.title}",
                                            style: TextStyle(
                                              color: CommonColor.darkGreyColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                faq.description,
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .mediumGreyColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        if (index !=
                                            settingProvider.faqs.length - 1)
                                          Divider(
                                              color:
                                                  CommonColor.mediumGreyColor,
                                              thickness: 0.3),
                                      ],
                                    ));
                              });
                }),
              )
              // ExpansionTile(
              //   iconColor: Colors.red[300],
              //   collapsedIconColor: CommonColor.primaryColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   collapsedShape: RoundedRectangleBorder(
              //     side: BorderSide.none,
              //   ),
              //   title: Text(
              //     "1. How can I place a new product order through the app?",
              //     style: TextStyle(
              //       color: CommonColor.darkGreyColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       child: Text(
              //         "You can place a new order by browsing the product catalog, selecting the desired items, choosing the quantity, and tapping the Place Order button. A confirmation screen will appear before finalizing your order.",
              //         style: TextStyle(color: CommonColor.mediumGreyColor),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(color: CommonColor.mediumGreyColor, thickness: 0.3),
              // ExpansionTile(
              //   iconColor: Colors.red[300],
              //   collapsedIconColor: CommonColor.primaryColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   collapsedShape: RoundedRectangleBorder(
              //     side: BorderSide.none,
              //   ),
              //   title: Text(
              //     "2. Can I track the status of my current orders?",
              //     style: TextStyle(
              //       color: CommonColor.darkGreyColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       child: Text(
              //         "Yes, you can track your orders under the “My Orders” section. It shows real-time status updates such as Pending, Processed, Shipped, or Delivered.",
              //         style: TextStyle(color: CommonColor.mediumGreyColor),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(color: CommonColor.mediumGreyColor, thickness: 0.3),
              // ExpansionTile(
              //   iconColor: Colors.red[300],
              //   collapsedIconColor: CommonColor.primaryColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   collapsedShape: RoundedRectangleBorder(
              //     side: BorderSide.none,
              //   ),
              //   title: Text(
              //     "3. What should I do if I receive the wrong or damaged product?",
              //     style: TextStyle(
              //       color: CommonColor.darkGreyColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       child: Text(
              //         "If you receive an incorrect or damaged product, go to the specific order, tap on 'Report an Issue,' and provide details or photos. Our support team will contact you to resolve it.",
              //         style: TextStyle(color: CommonColor.mediumGreyColor),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(color: CommonColor.mediumGreyColor, thickness: 0.3),
              // ExpansionTile(
              //   iconColor: Colors.red[300],
              //   collapsedIconColor: CommonColor.primaryColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   collapsedShape: RoundedRectangleBorder(
              //     side: BorderSide.none,
              //   ),
              //   title: Text(
              //     "4. Is it possible to cancel or modify an order after placing it?",
              //     style: TextStyle(
              //       color: CommonColor.darkGreyColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       child: Text(
              //         "No, you cannot. You can only cancel or modify an order before it is processed. Visit the 'My Orders' section, select the order, and choose Cancel or Edit if the options are still available.",
              //         style: TextStyle(color: CommonColor.mediumGreyColor),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(color: CommonColor.mediumGreyColor, thickness: 0.3),
              // ExpansionTile(
              //   iconColor: Colors.red[300],
              //   collapsedIconColor: CommonColor.primaryColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   collapsedShape: RoundedRectangleBorder(
              //     side: BorderSide.none,
              //   ),
              //   title: Text(
              //     "5. How do I manage product inventory within the app?",
              //     style: TextStyle(
              //       color: CommonColor.darkGreyColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       child: Text(
              //         "Admins or authorized shop staff can manage product inventory by going to the 'Inventory' section. From there, you can add new products, update stock levels, or deactivate unavailable items.",
              //         style: TextStyle(color: CommonColor.mediumGreyColor),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ));
  }
}
