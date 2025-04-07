import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/common/utils.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class ViewAvatarScreen extends StatelessWidget {
  const ViewAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "My Avatar",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
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
                color: CommonColor.primaryColor,
                size: 20,
              )),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.7,
              width: double.infinity,
              child: Consumer<SettingsProvider>(
                  builder: (context, avatarProvider, child) {
                return Image.memory(
                  avatarProvider.avatarBytes!,
                  fit: BoxFit.cover,
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColor.primaryColor,
                ),
                onPressed: () async {
                  try {
                    final settingProvider =
                        Provider.of<SettingsProvider>(context, listen: false);
                    await settingProvider.removeAvatar();
                    // await settingProvider.loadProfileAvatar();
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    Utilities.showCommonSnackBar(
                        context, "Avatar removed successfully");
                  } catch (e) {
                    if (!context.mounted) return;
                    Utilities.showCommonSnackBar(
                        context, "Failed to delete avatar");
                  }
                },
                child: Consumer<SettingsProvider>(
                    builder: (context, avatarProvider, child) {
                  return avatarProvider.isDeleteAvatarLoading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Remove Avatar",
                          style: TextStyle(color: Colors.white),
                        );
                }))
          ],
        ));
  }
}
