import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/localization/l10n.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final TextEditingController reportTextController = TextEditingController();
  @override
  void dispose() {
    reportTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: S.current.reportIssues,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: reportTextController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Please, explain us your experience!",
                      hintStyle: TextStyle(
                        color: CommonColor.darkGreyColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey[100]!), // Transparent border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: CommonColor.primaryColor,
                            width: 2), // Focused border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.red, width: 2), // Error border color
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2), // Focused error border color
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey), // Disabled border color
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: 10,
                    maxLength: 300,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(8)),
                    child: GestureDetector(
                      onTap: () async {
                        final imagePicker = ImagePicker();
                        final image = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          if (context.mounted) {
                            Utilities.showCommonSnackBar(
                                context, "Image Picked Successfuly!");
                          }
                        }
                      },
                      child: Center(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: 60,
                              Icons.image,
                              color: CommonColor.mediumGreyColor,
                            ),
                            Text(
                              "Insert Issues Image",
                              style:
                                  TextStyle(color: CommonColor.mediumGreyColor),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (reportTextController.text.isEmpty) {
                            Utilities.showCommonSnackBar(
                                context, "Please enter some issues to send!");
                          } else {
                            Utilities.showCommonSnackBar(
                                durationMilliseconds: 400,
                                context,
                                "Report sent successfully!");
                            Future.delayed(Duration(milliseconds: 1000), () {
                              if (!context.mounted) {
                                return;
                              }
                              Navigator.pop(context);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: CommonColor.primaryColor,
                        ),
                        child: Text(
                          S.current.sendReport,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
