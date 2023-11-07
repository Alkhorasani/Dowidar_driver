import 'package:dowidardriver/MVVM/ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../CustomWidgets/CustomNavigation_Bar.dart';
import '../../../Routing/AppRoutes.dart';
import '../Vw_Home/Vw_Home.dart';
import '../Vw_OrderHistory/Vw_OrderHistory.dart';
import '../Vw_Profile/Vw_Profile.dart';
import '../Vw_Settings/Vw_Settings.dart';

class CommonLayout extends StatefulWidget {
  @override
  _CommonLayoutState createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  final Vm_CommonLayout l_Vm_CommonLayout = Get.put(Vm_CommonLayout());

  PageController pageController = PageController(initialPage: 0);

  void onTabSelected(int index) {
    l_Vm_CommonLayout.selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Define methods to be executed when items are tapped
  void onHomeTapped() {
    print("I am home");
  }

  void onOrderHistoryTapped() {
    print("I am order history");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                onTabSelected(index);
              },
              children: [
                Vw_Home(),
                Vw_OrderHistory(),
                VwUserProfile(),
                Vw_Settings(),
              ],
            ),
          ),
          CustomBottomNavigationBar(
            onSelected: (int index) {
              onTabSelected(index);
            },
            onItemTapped: (int index) async {
              if (index == 0) {
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(), // Replace with your desired loading indicator widget
                  ),
                  barrierDismissible: false,
                );

                bool isCall = await l_Vm_CommonLayout.fnc_GetAllOrders();
                //bool isCustomerPortalUser = await l_Vmlogin.Fnc_IsUserPartOfCP();

                Get.back(); // Close the loading indicator dialog

                if (isCall) {
                  print("Api called");
                  Get.snackbar(
                    "Updated current  Orders",
                    "",
                    backgroundColor: Colors.grey[50],
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    duration: const Duration(seconds: 3),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 10,
                    borderWidth: 1,
                    borderColor: Colors.white,
                    messageText: const Text(
                      "----",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  Get.snackbar(
                    "These are your current orders for now.",
                    "",
                    backgroundColor: Colors.grey[50],
                    icon: const Icon(Icons.error_outline, color: Colors.redAccent),
                    duration: const Duration(seconds: 3),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 10,
                    borderWidth: 1,
                    borderColor: Colors.white,
                    messageText: const Text(
                      "----",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              } else if (index == 1) {
                await l_Vm_CommonLayout.filterOrderHistoryByStatus();
              }
            },
          ),
        ],
      ),
    );
  }
}
