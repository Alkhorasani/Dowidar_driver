import 'package:dowidardriver/MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectionDialog extends StatelessWidget {
  @override
  final Vm_Home l_Vmhome = Get.find<Vm_Home>();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(Locale('ar', 'SA'));
              l_Vmhome.isArabic.value = true;
              Get.back();
            },
            child: Text('عربي'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(Locale('en', 'US'));
              l_Vmhome.isArabic.value = false;

              Get.back();
            },
            child: Text('English'),
          ),
        ],
      ),
    );
  }
}
