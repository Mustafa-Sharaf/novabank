
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../Controller/MyAccounts_Controller.dart';

class SelectedAccountCard extends StatelessWidget {
  SelectedAccountCard({super.key});

  final controller = Get.find<AccountsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final account = controller.selectedAccount.value;

      if (account == null) {
        return const Text('No account selected.', style: TextStyle(color: Colors.grey));
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'SelectedAccount'.tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              account.type,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text('${"State".tr}: ${account.state}'),
            const SizedBox(height: 6),
            Text(
              '${"Balance".tr}: ${account.balance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}

