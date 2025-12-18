import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../Controller/Home_Controller.dart';
import '../widgets/BottomTabItem.dart';
import 'HomeContent_Screen.dart';
import 'More_Screen.dart';
import 'MyAccounts_Screen.dart';
import 'Transfer_Screen.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final BottomNavController controller = Get.put(BottomNavController());
  final List<Widget> pages = [
    HomeContentScreen(),
    MyAccountsScreen(),
    TransferScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //final themeController = Get.find<ThemeController>();
    return Scaffold(
      //backgroundColor: themeController.isDarkMode.value?AppColors.E : AppColors.white,
      appBar: AppBar(
        //backgroundColor: AppColors.primaryColor,
        actions: [
          Text(
            "Home_Screen".tr,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: MediaQuery.of(context).size.width * 0.055,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
          IconButton(
            icon: const Text('🔔', style: TextStyle(fontSize: 20)),
            onPressed: () => Get.toNamed('/notificationsScreen'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.logout, color: Colors.red),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
      body: Obx(
            () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.14,
          width: MediaQuery.of(context).size.width * 0.14,
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            elevation: 8,
            shape: const CircleBorder(),
            onPressed: () async {
              Get.toNamed('/profileScreen');
            },
            child: const Icon(Icons.person, size: 35, color: Colors.grey),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.0805,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: BottomTabItem(
                  index: 0,
                  icon: Icons.home,
                  label: 'Home'.tr,
                ),
              ),
              Expanded(
                child: BottomTabItem(
                  index: 1,
                  icon: Icons.account_balance,
                  label: 'MyAccounts'.tr,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              Expanded(
                child: BottomTabItem(
                  index:2,
                  icon: Icons.payments,
                  label: 'Transfer'.tr,
                ),
              ),
              Expanded(
                child: BottomTabItem(
                  index:3,
                  icon: Icons.menu,
                  label: 'More'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
