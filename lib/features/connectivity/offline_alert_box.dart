import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/common/common_color.dart';

class OfflineAlertBox extends StatelessWidget {
  const OfflineAlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          MingCute.wifi_off_line,
          size: 90,
          color: Colors.blue,
        ),
        Text(
          "No Internet Connection!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Center(
            child: Text(
          "Please check your network connection!",
          style: TextStyle(
            color: CommonColor.darkGreyColor,
          ),
          textAlign: TextAlign.center,
        )),
        SizedBox(
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.blue,
                  ),
                  Text(
                    "TRY AGAIN",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
