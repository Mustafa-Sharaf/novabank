import 'package:get/get.dart';

import 'MyAccounts_Controller.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
    if (index == 1) {
      Get.find<AccountsController>().fetchAccounts();
    }
  }
}
