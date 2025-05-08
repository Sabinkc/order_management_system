import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/send_email_otp_screen.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:order_management_system/localization/l10n.dart';

class TopProfileDashboard extends StatelessWidget {
  const TopProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SettingsProvider>(
                    builder: (context, settingProvider, child) {
                  return settingProvider.profile.emailVerified == true
                      ? SizedBox(
                          height: 1,
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SendEmailOtpScreen()));
                          },
                          child: Text(
                            S.current.verifyEmail,
                            style: TextStyle(
                                color: CommonColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                }),
                SizedBox(
                  height: 2,
                ),
                Consumer<SettingsProvider>(
                  builder: (context, profileProvider, child) {
                    final name = profileProvider.profile.name;
                    return Text(
                      "${S.current.hello}, $name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CommonColor.darkGreyColor,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 4,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    S.current.whatTo,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.current.buyToday,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, profileProvider, child) {
              return SizedBox(
                height: 50,
                width: 50,
                child: profileProvider.isAvatarLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: CommonColor.primaryColor,
                        ),
                      )
                    : profileProvider.avatarBytes == null
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                              size: 40,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.memory(
                                profileProvider.avatarBytes!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
              );
            },
          ),
        ],
      ),
    );
  }
}
