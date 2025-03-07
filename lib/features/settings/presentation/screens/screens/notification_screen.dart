import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_management_system/common/common_color.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});


 final  List<Map> notifications = [

    {
    "iconPath": "assets/icons/delivered.svg",
    "notificationDetail": "Your order for order no: 123456 is delivered.",
    "notificationTime": "10 minutes ago", 
  },

    {
    "iconPath": "assets/icons/out_for_delivery.svg",
    "notificationDetail": "Your order for order no: 123456 is out for delivery.",
    "notificationTime": "1 day ago", 
  },
    {
    "iconPath": "assets/icons/ready_to_ship.svg",
    "notificationDetail": "Your order for order no: 123456 is ready to be shipped.",
    "notificationTime": "Monday, 4:00 P.M.", 
  },
      {
    "iconPath": "assets/icons/order_processed.svg",
    "notificationDetail": "Your order for order no: 123456 is processed.",
    "notificationTime": "Monday, 7:00 A.M.", 
  },
    {
    "iconPath": "assets/icons/order_confirmed.svg",
    "notificationDetail": "Your order for order no: 123456 is confirmed.",
    "notificationTime": "Sunday, 11:45 P.M", 
  },
    {
    "iconPath": "assets/icons/order_placed.svg",
    "notificationDetail": "Your order for order no: 123456 has been placed.",
    "notificationTime": "Sunday, 11:30 A.M.", 
  },
 ];
  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonColor.primaryColor,
              size: 20,
            )),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Notifications",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  spacing: 15,
                  children: [
                    SvgPicture.asset(
                      notifications[index]["iconPath"],
                      height: 40,
                      width: 40,
                      colorFilter: ColorFilter.mode(
                          CommonColor.primaryColor, BlendMode.srcIn),
                    ),
                    // Icon(
                    //   Icons.notifications,
                    //   size: 28,
                    //   color: CommonColor.primaryColor,
                    // ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 3,
                      children: [
                        Text(
                          notifications[index]["notificationDetail"],
                          style: TextStyle(
                              color: CommonColor.darkGreyColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(notifications[index]["notificationTime"],
                            style: TextStyle(
                              color: CommonColor.darkGreyColor,
                            )),
                      ],
                    ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
