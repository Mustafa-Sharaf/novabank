import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/MyAccounts_Model.dart';

class AccountsController extends GetxController {
  var accounts = <AccountsModel>[].obs;
  var isLoading = false.obs;

  final selectedAccount = Rxn<AccountsModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
  }


  void selectAccount(AccountsModel account) {
    selectedAccount.value = account;
  }

  Future<void> fetchAccounts() async {
    final token = GetStorage().read("token");
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('http://novasys.runasp.net/api/Accounts/UserAccounts'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        accounts.value = data.map((e) => AccountsModel.fromJson(e)).toList();
        if (accounts.isNotEmpty) {
          selectedAccount.value = accounts[0];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch accounts: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
