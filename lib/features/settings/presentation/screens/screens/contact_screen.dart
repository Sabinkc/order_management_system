import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/localization/l10n.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
                  text: S.current.contactUs,
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
            spacing: 10,
            children: [
              SizedBox(
                height: 2,
              ),
              Text(
                "You can get in touch with us through below platforms. Our team will reach out to you as soon as it would be possible.",
                style: TextStyle(color: CommonColor.mediumGreyColor),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(
                      "Customer Support",
                      style: TextStyle(
                          color: CommonColor.mediumGreyColor, fontSize: 16),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: CommonColor.commonGreyColor,
                          child: Icon(
                            Icons.phone_outlined,
                            color: CommonColor.mediumGreyColor,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact Number",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "+9812345678",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: CommonColor.commonGreyColor,
                          child: Icon(
                            Icons.email_outlined,
                            color: CommonColor.mediumGreyColor,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email Address",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "johndoe@gmail.com",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(
                      "Social Media",
                      style: TextStyle(
                          color: CommonColor.mediumGreyColor, fontSize: 16),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: CommonColor.commonGreyColor,
                          child: Brand(
                            Brands.instagram,

                            // color: CommonColor.mediumGreyColor,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Instagram",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "@instagram_user",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: CommonColor.commonGreyColor,
                          child: Brand(
                            Brands.facebook,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Facebook",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "@facebook_user",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: CommonColor.commonGreyColor,
                          child: Brand(
                            Brands.twitter,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Twitter",
                                style: TextStyle(
                                    color: CommonColor.mediumGreyColor),
                              ),
                              Text(
                                "@twitter_user",
                                style: TextStyle(
                                    color: CommonColor.darkGreyColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
