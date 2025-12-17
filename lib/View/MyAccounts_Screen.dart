import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../Controller/MyAccounts_Controller.dart';
import 'HomeContent_Screen.dart';

class MyAccountsScreen extends StatelessWidget {
  const MyAccountsScreen({super.key});

  IconData getAccountIcon(String type) {
    switch (type.toLowerCase()) {
      case 'saving':
        return Icons.savings;
      case 'checking':
        return Icons.account_balance_wallet;
      case 'loan':
        return Icons.request_quote;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.account_balance;
    }
  }

  Color getCardColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'saving':
        return Colors.green.shade50;
      case 'checking':
        return Colors.blue.shade50;
      case 'loan':
        return Colors.red.shade50;
      case 'investment':
        return Colors.purple.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountsController>();
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (controller.accounts.isEmpty) {
          return const Center(
            child: Text(
              'No accounts available.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: controller.accounts.length,
          itemBuilder: (context, index) {
            final account = controller.accounts[index];

            return GestureDetector(
              onTap: () {
                controller.selectAccount(account);
              },
              child: Card(
                color: getCardColorByType(account.type),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            getAccountIcon(account.type),
                            color: AppColors.primaryColor,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Account ${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, thickness: 1.2),
                      Text('Account code: ${account.id}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('Type: ${account.type}', style: const TextStyle(fontWeight: FontWeight.w500)),
                      Text('State: ${account.state}'),
                      Text('Created at: ${account.createdAt.toLocal()}'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              account.balance.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            getAccountIcon(account.type),
                            color: AppColors.primaryColor,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Account ${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, thickness: 1.2),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type: ${account.type}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text('State: ${account.state}'),
                              Text(
                                'Created at: ${account.createdAt.toLocal()}',
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              account.balance.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),*/

                ),
              ),
            );
          },
        );
      }),
    );
  }
}
