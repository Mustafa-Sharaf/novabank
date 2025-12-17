
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../App_theme/AppColors.dart';
import '../App_theme/Themem_Controller.dart';
import '../Controller/CurrentUser_Controller.dart';
import '../widgets/LanguageBottomSheet.dart';

class ProfileScreen extends StatelessWidget {
  //const ProfileScreen({super.key});
  final controller = Get.find<CurrentUserController>();
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();


    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final user = controller.user.value;

      if (user == null) {
        return Scaffold(body: Center(child: Text('NoUserData'.tr)));
      }

      return Scaffold(
        backgroundColor: themeController.isDarkMode.value
            ? AppColors.E
            : AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                user.userName,
                style: GoogleFonts.cairo(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: themeController.isDarkMode.value
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),

              Text(
                user.email,
                style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
              ),

              Text(
                user.phoneNumber,
                style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 35),
              const Divider(),

              ProfileItem(
                icon: Icons.language,
                title: "LanguageEditing".tr,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (_) => LanguageBottomSheet(),
                  );
                },
              ),

              ProfileItem(
                icon: Icons.color_lens,
                title: "discoloration".tr,
                onTap: () => themeController.toggleTheme(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 25),
      leading: Icon(icon, size: 30, color: AppColors.primaryColor),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/CurrentUser_Controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.find<CurrentUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = controller.user.value;
        print("controller.user.value.email==${controller.user.value?.email}");
        if (user == null) {
          return const Center(child: Text('No user data'));
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoTile('Username', user.userName),
              _infoTile('Email', user.email),
              _infoTile('Phone', user.phoneNumber),
              _infoTile('Role', user.role),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
*/
