import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class TermsOfConditionsScreen extends StatefulWidget {
  const TermsOfConditionsScreen({super.key});

  @override
  State<TermsOfConditionsScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<TermsOfConditionsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        final settingProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        await settingProvider.fetchTermsAndConditions();
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
                text: "Terms and Conditions",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              height: 0,
            ),
            Text(
              "Please read our Terms and Conditions carefully before using this app.",
              style: TextStyle(color: CommonColor.darkGreyColor),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<SettingsProvider>(
                builder: (context, settingProvider, child) {
              return Expanded(
                  child: settingProvider.isTermsLoading &&
                          settingProvider.termsAndConditions.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        ))
                      : settingProvider.termsAndConditions.isEmpty
                          ? Center(
                              child:
                                  Text("Failed to fetch terms and conditions"))
                          : ListView.builder(
                              itemCount:
                                  settingProvider.termsAndConditions.length,
                              itemBuilder: (context, index) {
                                final term =
                                    settingProvider.termsAndConditions[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        "${term.id}. ${term.title}",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        term.description,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                );
                              }));
            })
          ],
        ),
      ),
    );
  }
}
