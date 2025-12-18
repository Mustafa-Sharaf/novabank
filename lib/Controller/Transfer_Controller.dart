import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Model/Transaction_Model.dart';


class TransferController extends GetxController {
  final fromAccountIdController = TextEditingController();
  final toAccountIdController = TextEditingController();
  final amountController = TextEditingController();

  var isLoading = false.obs;
  var transactions = <TransactionModel>[].obs;
  var errorMessage = ''.obs;

  Future<void> transfer() async {
    final fromId = int.tryParse(fromAccountIdController.text);
    final toId = int.tryParse(toAccountIdController.text);
    final amount = int.tryParse(amountController.text);

    if (fromId == null || toId == null || amount == null || amount <= 0) {
      Get.snackbar(
          'Error',
          'Please enter valid data',
        backgroundColor: Colors.red
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(
            'http://novasys.runasp.net/api/Transactions/$fromId/Transfer'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'toAccountId': toId,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final transaction = TransactionModel.fromJson(data);

        // ✅ أضف التحويل إلى القائمة
        transactions.insert(0, transaction);

        // تنظيف الحقول
        amountController.clear();
        toAccountIdController.clear();

        Get.snackbar(
            'Success',
            'Transfer completed successfully',
            backgroundColor: Colors.green);
      } else {
        Get.snackbar(
            'Error',
            'Failed: ${response.statusCode}',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void deleteTransaction(int index) {
    transactions.removeAt(index);
    Get.snackbar(
      'Deleted',
      'Transaction removed successfully',
      backgroundColor: Colors.green,
    );
  }


  @override
  void onClose() {
    fromAccountIdController.dispose();
    toAccountIdController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
