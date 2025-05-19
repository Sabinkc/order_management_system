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
      if (mounted) {
        final settingProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        await settingProvider.fetchFaq();
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "We are here to help you with anything and every thing on this app.",
                  style: TextStyle(color: CommonColor.mediumGreyColor),
                ),
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
                                            textAlign: TextAlign.justify,
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
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .mediumGreyColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        if (index !=
                                            settingProvider.faqs.length - 1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Divider(
                                                color:
                                                    CommonColor.mediumGreyColor,
                                                thickness: 0.3),
                                          ),
                                      ],
                                    ));
                              });
                }),
              )
            ],
          ),
        ));
  }
}
