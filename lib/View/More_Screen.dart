import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/BottomMoreItem.dart';
import 'AboutBank_Screen.dart';
import 'ExchangeRate_Screen.dart';
import 'LocationScreen.dart';
import 'Profit_Screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children:  [
            MoreItem(
              icon: Icons.trending_up,
              title: "ProfitCalculation".tr,
              color: const Color(0xFF4CAF50),
              onTap: () => Get.to(() =>  ProfitScreen()),
            ),
            MoreItem(
              icon: Icons.location_on,
              title: "Location".tr,
              color: const Color(0xFF2196F3),
              onTap: () => Get.to(() => const LocationScreen()),
            ),
            MoreItem(
              icon: Icons.currency_exchange,
              title: "ExchangeRate".tr,
              color: const Color(0xFFFF9800),
              onTap: () => Get.to(() => const ExchangeRateScreen()),
            ),
            MoreItem(
              icon: Icons.info_outline,
              title: "AboutNovaBank".tr,
              color: const Color(0xFF9C27B0),
              onTap: () => Get.to(() => const AboutBankScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
