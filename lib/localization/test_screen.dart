import 'package:flutter/material.dart';
import 'package:order_management_system/localization/l10n.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(S.current.name), Text(S.current.hello_world)],
      ),
    ));
  }
}
