// import 'package:flutter/material.dart';
// import 'package:order_management_system/common/common_color.dart';
// import 'package:order_management_system/features/settings/domain/settings_provider.dart';
// import 'package:provider/provider.dart';

// class TopProfileDashboard extends StatelessWidget {
//   const TopProfileDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//         Expanded(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Consumer<SettingsProvider>(
//                 builder: (context, profileProvider, child) {
//               return Text("Hello,${profileProvider.profile.name}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: CommonColor.darkGreyColor,
//                   ));
//             }),
//             Text(
//               "What would you like to buy today?",
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//             )
//           ]),
//         ),
//         SizedBox(
//             height: 50,
//             width: 50,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: Image.asset(
//                 "assets/images/profile.jpeg",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:order_management_system/common/common_color.dart';
import 'package:order_management_system/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<SettingsProvider>(
                  builder: (context, profileProvider, child) {
                return Text("Hello,${profileProvider.profile.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CommonColor.darkGreyColor,
                    ));
              }),
              Text(
                "What would you like to buy today?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )
            ]),
          ),
          Consumer<SettingsProvider>(
            builder: (context, profileProvider, child) {
              // Load avatar when widget builds if not already loaded
              if (profileProvider.avatarBytes == null &&
                  !profileProvider.isAvatarLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  profileProvider.loadProfileAvatar();
                });
              }

              return SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _buildAvatarImage(profileProvider)),
                    if (profileProvider.isAvatarLoading)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(SettingsProvider profileProvider) {
    // First try to show the avatar bytes if available
    if (profileProvider.avatarBytes != null) {
      return Image.memory(
        profileProvider.avatarBytes!,
        fit: BoxFit.cover,
      );
    }
    // Fall back to network image from profile if available
    else if (profileProvider.profile.avatar != null &&
        profileProvider.profile.avatar!.isNotEmpty) {
      return Image.network(
        profileProvider.profile.avatar!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
      );
    }
    // Default avatar
    else {
      return _buildDefaultAvatar();
    }
  }

  Widget _buildDefaultAvatar() {
    return Image.asset(
      "assets/images/profile.jpeg",
      fit: BoxFit.cover,
    );
  }
}
