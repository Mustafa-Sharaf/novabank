import 'package:flutter/material.dart';
import 'package:novabank/App_theme/AppColors.dart';

class AboutBankScreen extends StatelessWidget {
  const AboutBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About NovaBank"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Bank Icon
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

            /// Bank Name
            Text(
              "NovaBank",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Your Digital Banking Partner",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 30),

            /// Info Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _AboutItem(
                      icon: Icons.security,
                      text:
                      "NovaBank is a modern digital bank providing fast and secure banking services.",
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.credit_card,
                      text:
                      "Easily manage your accounts, payments, and transfers anytime, anywhere.",
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.lock,
                      text:
                      "We apply the highest security standards to protect your financial data.",
                    ),
                    SizedBox(height: 12),
                    _AboutItem(
                      icon: Icons.trending_up,
                      text:
                      "Our goal is to deliver a smart banking experience tailored to your needs.",
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
