import 'package:flutter/material.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {

                final settingProvider =
                    Provider.of<SettingsProvider>(context, listen: false);
                // settingProvider.updatProfile("sabin", "sabinkc1206@gmail.com",
                //     "9812060688", "male", "Ilam");
                settingProvider.changePassword("oldpassword", "newpassword");
              },
              child: Text("Press")),
          Center(child: Text("Test Screen")),
        ],
      ),
    );
  }
}

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}

// import 'package:flutter/material.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Text("Invoice Screen")),
//     );
//   }
// }
