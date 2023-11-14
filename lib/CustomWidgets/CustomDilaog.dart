import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.updateLocale(Locale('ur', 'PK')); // Set Urdu as the selected language
            },
            child: Text('اردو'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.updateLocale(Locale('en', 'US')); // Set English as the selected language
            },
            child: Text('English'),
          ),
        ],
      ),
    );
  }
}