import 'package:flutter/material.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
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
  TextEditingController reportController = TextEditingController();

  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        settingsProvider.clearReportData();
      },
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: CommonColor.scaffoldbackgroundColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            title: Text(
              S.current.reportIssues,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                settingsProvider.clearReportData();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<SettingsProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        controller: reportController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Please, explain us your experience!",
                          hintStyle:
                              TextStyle(color: CommonColor.darkGreyColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[100]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: CommonColor.primaryColor, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 10,
                        maxLines: 10,
                        maxLength: 300,
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await provider.pickImage();
                          } catch (e) {
                            if (context.mounted) {
                              Utilities.showCommonSnackBar(context, "$e",
                                  color: Colors.red);
                            }
                          }
                        },
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: provider.pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    provider.pickedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          size: 60,
                                          color: CommonColor.mediumGreyColor),
                                      Text("Insert Issues Image",
                                          style: TextStyle(
                                              color:
                                                  CommonColor.mediumGreyColor)),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (reportController.text.trim().isEmpty) {
                              Utilities.showCommonSnackBar(
                                  context, "Please enter some issues to send!",
                                  color: Colors.red);
                            } else if (provider.pickedImage == null) {
                              Utilities.showCommonSnackBar(context,
                                  "Please attach an image of the issue!",
                                  color: Colors.red);
                            } else {
                              try {
                                await provider.sendReport(
                                  imageFile: provider.pickedImage!,
                                  heading: "Issue Report",
                                  description: reportController.text.trim(),
                                );
                                provider.clearReportData();

                                if (context.mounted) {
                                  Navigator.pop(context);
                                  Utilities.showCommonSnackBar(
                                      context, "Report sent successfully!",
                                      icon: Icons.check);
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  Utilities.showCommonSnackBar(context, "$e",
                                      color: Colors.red);
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: CommonColor.primaryColor,
                          ),
                          child: provider.isSendingReport == true
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  S.current.sendReport,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
