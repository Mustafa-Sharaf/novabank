

import 'package:flutter/material.dart';

import '../App_theme/AppColors.dart';

class MyAccountsScreen extends StatelessWidget {
  const MyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("MyAccountsScreen"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
