
import 'package:dowidardriver/MVVM/ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import '../../Routing/AppRoutes.dart';

class cm_HandleDeepLink {


  handleDeepLink({BuildContext? context, required String deeplink, dynamic payLoad}) {

    final Vm_CommonLayout l_Vm_CommonLayout = Get.put(Vm_CommonLayout());
    switch (deeplink){
      case 'order':
        l_Vm_CommonLayout.fnc_GetAllOrders();

        Get.toNamed(AppRoutes.vwHome);
        break;
      default:
        throw ErrorDescription('$deeplink type of notification is not handled yet.');
    }
  }
}