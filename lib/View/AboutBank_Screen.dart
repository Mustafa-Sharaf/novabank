import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novabank/App_theme/AppColors.dart';

class AboutBankScreen extends StatelessWidget {
  const AboutBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AboutNovaBank".tr),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.account_balance,
                size: 45,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "NovaBank".tr,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "YourDigitalBankingPartner".tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AboutItem(
                      icon: Icons.security,
                      text:
                      "NovaBankServices".tr,
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.credit_card,
                      text:
                      "EasilyManage".tr,
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.lock,
                      text:
                      "WeApply".tr,
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.trending_up,
                      text:
                      "OurGoal".tr,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}
class _AboutItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AboutItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
        ),
      ],
    );
  }
}
