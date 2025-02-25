import 'dart:developer' as logger;
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:provider/provider.dart';

class GoogleButtonLogin extends StatelessWidget {
  const GoogleButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<AuthProvider>(builder: (context, authProvider,child){
      return GestureDetector(
      onTap: () async {
        logger.log("Google Sign-In button tapped");
  //  final GoogleSignInApiService googleSignInApiService = GoogleSignInApiService();
  //        await googleSignInApiService.signIn(context);
         final authProvider = Provider.of<AuthProvider>(context,listen: false);
         await authProvider.loginWithGoogle(context);
        
      },
      child: Container(
        height: screenHeight * 0.065,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Brand(Brands.google, size: 30),
              Text(
                "Google",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
    });


  }

}
