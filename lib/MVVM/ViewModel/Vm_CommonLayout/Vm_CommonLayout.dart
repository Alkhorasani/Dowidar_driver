import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ServiceLayer/Sl_GetAllOrders.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';

class Vm_CommonLayout extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxDouble iconSize = 28.0.obs;
  RxList<Datum>? RxListModUserAllOrders = <Datum>[].obs;
  RxList<Datum>? RxListModOrderHistory = <Datum>[].obs;
  RxBool isLoading = false.obs;

  Future<bool> fnc_GetAllOrders() async {
    try {
      ModGetAllOrders l_ModGetAllOrders = await Sl_GetAllOrders().fnc_GetAllorders_apiCall();
      List<Datum> l_list_ModGetAllOrders = [];
      List<Datum> ordersList = [];

      if (l_ModGetAllOrders != null) {
        ordersList.clear();
        l_list_ModGetAllOrders.clear();
        RxListModUserAllOrders?.value.clear();
        ordersList = l_ModGetAllOrders.data.data;

        l_list_ModGetAllOrders = ordersList.map((orderJson) {
          return orderJson;
        }).toList();

        RxListModUserAllOrders?.value = l_list_ModGetAllOrders ?? [];
        print(RxListModUserAllOrders);
        print(RxListModUserAllOrders);
        // print(l_list_ModGetAllOrders);

        print("Called");
        return true;
      } else {
        print("failed");
        return false;
      }
    } catch (e) {
      print("Error in fnc_GetAllOrders: $e");
      return false; // You can handle the error as needed
    }
  }

  bool filterOrderHistoryByStatus() {
    try {
      // Assuming that RxListModUserAllOrders is a list of Datum objects
      if (RxListModUserAllOrders != null) {
        final filteredOrders = RxListModUserAllOrders!.where((order) => order.status == 'cancelled').toList();
        RxListModOrderHistory?.assignAll(filteredOrders);
        return true;  // Filtering and assignment succeeded
      } else {
        return false;  // RxListModUserAllOrders is null
      }
    } catch (error) {
      print("Error in filterOrderHistoryByStatus: $error");
      return false;  // Error occurred
    }
  }

}
