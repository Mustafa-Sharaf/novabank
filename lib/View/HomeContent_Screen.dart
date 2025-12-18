import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novabank/App_theme/AppColors.dart';
import '../Controller/Transfer_Controller.dart';
import '../widgets/SelectedAccountCard.dart';
import '../widgets/WelcomeUserCard.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transferController = Get.find<TransferController>();

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
              Row(
                children: [
                  Text(
                    "LatestTransfers".tr,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              transferController.transactions.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: transferController.transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transferController.transactions[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            color: Colors.green.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('${"TransactionNumber".tr}: ${tx.id}'),
                                      InkWell(
                                        onTap: () {
                                          transferController.deleteTransaction(
                                            index,
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text('${"Amount".tr}: ${tx.amount}'),
                                  Text('${"Status".tr}: ${tx.status}'),
                                  Text('${"FromAccount".tr}: ${tx.fromAccountId}'),
                                  Text('${"ToAccount".tr}: ${tx.toAccountId}'),
                                  Text(
                                    '${"ApprovedAt".tr}: ${tx.approvedAt.toLocal()}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        "No Transaction",
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
