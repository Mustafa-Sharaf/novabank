import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../language/Language_Controller.dart';


class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});



  @override
  Widget build(BuildContext context) {
    final MyLanguageController langController = Get.find<MyLanguageController>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "LanguageEditing".tr,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          ListTile(
            leading: Image.asset("assets/Images/Syria.png", width: 35),
            title: Text("العربية", style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              langController.changeLanguage("ar");
              Get.back();
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset("assets/Images/Britain.png", width: 35),
            title: Text("English", style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              langController.changeLanguage("en");
              Get.back();
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset("assets/Images/Franca.png", width: 35),
            title: Text("Français", style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              langController.changeLanguage("fr");
              Get.back();
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset("assets/Images/Turkce.png", width: 35),
            title: Text("Türkçe", style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              langController.changeLanguage("tr");
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
