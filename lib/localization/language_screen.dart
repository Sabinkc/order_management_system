import 'package:flutter/material.dart';
import 'package:order_management_system/localization/l10n.dart';
import 'package:order_management_system/localization/localization_provider.dart';
import 'package:order_management_system/localization/model.dart';

import 'package:provider/provider.dart';



class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
      var groupValue = localizationProvider.locale.languageCode;
      return Scaffold(
        appBar: AppBar(
          title: Text(S.current.language),
        ),
        body: ListView.builder(
          itemCount: languageModel.length,
          itemBuilder: (context, index) {
            var item = languageModel[index];
            return RadioListTile(
              value: item.languageCode,
              groupValue: groupValue,
              title: Text(item.language),
              subtitle: Text(item.subLanguage),
              onChanged: (value) {
                groupValue = value.toString();
                localizationProvider.setLocale(Locale(item.languageCode));
              },
            );
          },
        ),
      );
    });
  }
}