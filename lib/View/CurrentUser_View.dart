import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CurrentUser_Controller.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(CurrentUserController());


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
