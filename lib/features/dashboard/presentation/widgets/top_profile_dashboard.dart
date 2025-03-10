import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class TopProfileDashboard extends StatelessWidget {
  const TopProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hello,John",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: CommonColor.darkGreyColor,
                                    )),
                                Text(
                                  "What would you like to buy today?",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                )
                              ]),
                        ),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/profile.jpeg",
                                fit: BoxFit.cover,
                              ),
                            )),
                      ]),
                );
  }
}