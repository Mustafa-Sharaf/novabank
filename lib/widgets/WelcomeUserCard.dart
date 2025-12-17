import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../App_theme/AppColors.dart';
import '../Controller/CurrentUser_Controller.dart';

class WelcomeUserCard extends StatelessWidget {
  WelcomeUserCard({super.key});

  final controller = Get.find<CurrentUserController>();

  String lastSeenText() {
    final box = GetStorage();
    final value = box.read('lastSeen');

    if (value == null) return 'First time';

    final lastSeen = DateTime.parse(value);
    final diff = DateTime.now().difference(lastSeen);

    if (diff.inMinutes < 1) return 'Online now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';

    return '${diff.inDays} days ago';
  }


  @override
  Widget build(BuildContext context) {
    GetStorage().write('lastLogin', DateTime.now().toIso8601String());

    return Obx(() {
      final user = controller.user.value;

      if (user == null) {
        return const SizedBox();
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome 👋',
              style: GoogleFonts.cairo(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              user.userName,
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              lastSeenText(),
              style: GoogleFonts.cairo(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),

          ],
        ),
      );
    });
  }
}
