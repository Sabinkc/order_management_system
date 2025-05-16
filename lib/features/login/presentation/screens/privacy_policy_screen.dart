import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        final settingProvider =
            Provider.of<SettingsProvider>(context, listen: false);
        await settingProvider.fetchPolicies();
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
                text: "Privacy Policy",
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
              "We value your privacy. This app collects and stores only the necessary data required to manage your orders efficiently.",
              style: TextStyle(color: CommonColor.darkGreyColor),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<SettingsProvider>(
                builder: (context, settingProvider, child) {
              return Expanded(
                  child: settingProvider.isPolicyLoading &&
                          settingProvider.privacyPolicies.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: CommonColor.primaryColor,
                        ))
                      : settingProvider.privacyPolicies.isEmpty
                          ? Center(
                              child: Text("Failed to fetch privacy policies"))
                          : ListView.builder(
                              itemCount: settingProvider.privacyPolicies.length,
                              itemBuilder: (context, index) {
                                final policy =
                                    settingProvider.privacyPolicies[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        "${policy.id}. ${policy.title}",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        policy.description,
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
