import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../App_theme/Themem_Controller.dart';
import '../Controller/Transfer_Controller.dart';

class TransferScreen extends StatelessWidget {
  TransferScreen({super.key});
  final TransferController transferController = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: transferController.fromAccountIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "FromAccount".tr,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: transferController.toAccountIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "ToAccount".tr,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: transferController.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount".tr,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 26),
            transferController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => transferController.transfer(),
                      child:  Text('Transfer'.tr,style: TextStyle(color: Colors.white),),
                    ),
                  ),
            const SizedBox(height: 16),
            if (transferController.transactions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transferController.transactions.length,
                itemBuilder: (context, index) {
                  final tx = transferController.transactions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    //color: Colors.green.shade50,
                    color: themeController.isDarkMode.value
                        ? AppColors.componentDark
                        : AppColors.componentLight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${"TransactionNumber".tr}: ${tx.id}'),
                              InkWell(
                                onTap: () {
                                  transferController.deleteTransaction(index);
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

          ],
        ),
      ),
    );
  }
}
