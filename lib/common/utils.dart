import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';

class Utilities {
  static showCommonSnackBar(BuildContext context, String text,
      {IconData icon = Icons.warning,
      Color color = Colors.green,
      int durationMilliseconds = 1000}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(
              icon,
              color: CommonColor.whiteColor,
              size: 30,
            ),
            Expanded(
              child: Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        )),
        duration: Duration(milliseconds: durationMilliseconds),
      ),
    );
  }

  static showCommonConfirmationBox(BuildContext context,
      {String headerMessage = "",
      String bodyMessage = "",
      String leftConfirmationMessage = "",
      String rightConfirmationMessage = "",
      void Function()? onLeftButtonPressed,
      void Function()? onRightButtonPressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              titlePadding: EdgeInsets.only(
                top: 12,
                bottom: 10,
              ),
              contentPadding: EdgeInsets.only(bottom: 12),
              title: Text(
                headerMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      bodyMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: CommonColor.darkGreyColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: CommonColor.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: onLeftButtonPressed,
                            child: Text(
                              leftConfirmationMessage,
                              style: TextStyle(color: CommonColor.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: 122,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: CommonColor.primaryColor,
                            ),
                            onPressed: onRightButtonPressed,
                            child: Text(
                              rightConfirmationMessage,
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
