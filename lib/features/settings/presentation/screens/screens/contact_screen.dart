import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        final settingProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        await settingProvider.fetchContacts();
      }
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
        body: SingleChildScrollView(
          child: Padding(
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
                Consumer<SettingsProvider>(
                    builder: (context, settingsProvider, child) {
                  final List supportContacts = settingsProvider.contacts
                      .where((element) => element.type == "support")
                      .toList();
                  final List socialMediaContacts = settingsProvider.contacts
                      .where((element) => element.type == "social-media")
                      .toList();
                  return settingsProvider.contacts.isEmpty &&
                          settingsProvider.isContactsLoading
                      ? CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        )
                      : settingsProvider.contacts.isEmpty
                          ? Text("Failed to fetch contacts")
                          : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "Customer Support",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor,
                                            fontSize: 16),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: supportContacts.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                spacing: 10,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: CommonColor
                                                        .commonGreyColor,
                                                    // child: Icon(
                                                    //   Icons.phone_outlined,
                                                    //   color: CommonColor
                                                    //       .mediumGreyColor,
                                                    // ),
                                                    child: Icon(
                                                      Icons
                                                          .contact_support_outlined,
                                                      color: CommonColor
                                                          .mediumGreyColor,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          supportContacts[index]
                                                              .field,
                                                          style: TextStyle(
                                                              color: CommonColor
                                                                  .mediumGreyColor),
                                                        ),
                                                        Text(
                                                          supportContacts[index]
                                                              .value,
                                                          style: TextStyle(
                                                              color: CommonColor
                                                                  .darkGreyColor,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "Social Media",
                                        style: TextStyle(
                                            color: CommonColor.mediumGreyColor,
                                            fontSize: 16),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: socialMediaContacts.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                spacing: 10,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: CommonColor
                                                        .commonGreyColor,
                                                    // child: Brand(
                                                    //   Brands.facebook,
                                                    // ),
                                                    child: Icon(
                                                      Icons.toll_outlined,
                                                      color: CommonColor
                                                          .mediumGreyColor,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          socialMediaContacts[
                                                                  index]
                                                              .field,
                                                          style: TextStyle(
                                                              color: CommonColor
                                                                  .mediumGreyColor),
                                                        ),
                                                        Text(
                                                          socialMediaContacts[
                                                                  index]
                                                              .value,
                                                          style: TextStyle(
                                                              color: CommonColor
                                                                  .darkGreyColor,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            );
                })
              ],
            ),
          ),
        ));
  }
}
