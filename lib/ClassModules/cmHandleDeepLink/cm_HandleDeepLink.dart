import 'package:dowidardriver/MVVM/ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import '../../Routing/AppRoutes.dart';
import '../cmGlobalVariables/cmGlobalVariables.dart';

class cm_HandleDeepLink {
  handleDeepLink({required String deeplink, dynamic payLoad, dynamic payLoadrecid }) async {
    final Vm_CommonLayout l_Vm_CommonLayout = Get.put(Vm_CommonLayout());
    switch (deeplink) {
      case 'order':
        l_Vm_CommonLayout.fnc_GetAllOrders();

        Get.toNamed(AppRoutes.vwHome);
        break;
      case 'message':
        final l_SharedPreferences = await SharedPreferences.getInstance();
        final id = l_SharedPreferences.getString('l_driverID') ?? '';
        cmGlobalVariables.pbDriberID = id;
        cmGlobalVariables.pBChatOrderId = int.parse(payLoad);
        cmGlobalVariables.pBChatReciverId = payLoadrecid.toString();
        print(cmGlobalVariables.pBChatOrderId);
        Get.toNamed(AppRoutes.vwChat);

      default:
        throw ErrorDescription('$deeplink type of notification is not handled yet.');
    }
  }
}
