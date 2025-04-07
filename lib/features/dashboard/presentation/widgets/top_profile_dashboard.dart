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

class TopProfileDashboard extends StatefulWidget {
  const TopProfileDashboard({super.key});

  @override
  State<TopProfileDashboard> createState() => _TopProfileDashboardState();
}

class _TopProfileDashboardState extends State<TopProfileDashboard> {
  bool _hasLoadError = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      _loadAvatar();
    });
  }

  Future<void> _loadAvatar() async {
    final profileProvider = context.read<SettingsProvider>();
    try {
      await profileProvider.loadProfileAvatar();
      if (mounted) setState(() => _hasLoadError = false);
    } catch (e) {
      if (mounted) {
        setState(() => _hasLoadError = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load avatar: ${e.toString()}')),
        );
      }
    }
  }

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
                  builder: (context, profileProvider, child) {
                    final name = profileProvider.profile.name;
                    return Text(
                      "Hello, $name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CommonColor.darkGreyColor,
                      ),
                    );
                  },
                ),
                const Text(
                  "What would you like to buy today?",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Consumer<SettingsProvider>(
            builder: (context, profileProvider, child) {
              return SizedBox(
                height: 50,
                width: 50,
                child: profileProvider.isAvatarLoading && !_hasLoadError
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: CommonColor.primaryColor,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _buildAvatarImage(profileProvider),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(SettingsProvider profileProvider) {
    if (profileProvider.avatarBytes != null) {
      return Image.memory(
        profileProvider.avatarBytes!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildBrokenAvatar(),
      );
    }
    return _buildBrokenAvatar();
  }

  Widget _buildBrokenAvatar() {
    return GestureDetector(
      onTap: _loadAvatar, // Allow retry on tap
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }
}
