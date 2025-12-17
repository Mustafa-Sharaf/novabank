/*
import 'package:flutter/material.dart';

import '../widgets/SelectedAccountCard.dart';
import '../widgets/WelcomeUserCard.dart';


class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WelcomeUserCard(),
              const SizedBox(height: 16),
              SelectedAccountCard(),


            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/MyAccounts_Controller.dart';
import '../widgets/SelectedAccountCard.dart';
import '../widgets/WelcomeUserCard.dart';
import 'Transfer_Screen.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountsController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WelcomeUserCard(),
              const SizedBox(height: 16),
              SelectedAccountCard(),
              const SizedBox(height: 16),
              //TransferScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
