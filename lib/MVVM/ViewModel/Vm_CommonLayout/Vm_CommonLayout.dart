import 'package:dowidardriver/Enum/EnumStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ServiceLayer/Sl_GetAllOrders.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';

class Vm_CommonLayout extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxDouble iconSize = 28.0.obs;
  RxList<Order>? RxListModUserAllOrders = <Order>[].obs;
  RxList<Order>? RxListModUserProcessingEnrOrders = <Order>[].obs;
  RxList<Order>? RxListModOrderHistory = <Order>[].obs;
  RxList<Order>? RxListModOrderPenidngNew = <Order>[].obs;
  RxBool isLoadingAllOrders = false.obs;
  RxBool isLoadingPendingOrders = false.obs;
  RxBool isLoadingPendingNewOrders = false.obs;
  RxBool isLoadingOrderHistory = false.obs;

  Future<bool> fnc_GetAllOrders() async {
    try {
      isLoadingAllOrders.value = true; // Show loading indicator
      ModGetAllOrders l_ModGetAllOrders = await Sl_GetAllOrders().fnc_GetAllorders_apiCall();
      List<Order> l_list_ModGetAllOrders = [];
      List<Order>? ordersList = [];

      if (l_ModGetAllOrders != null) {
        ordersList.clear();
        l_list_ModGetAllOrders.clear();
        RxListModUserAllOrders?.value.clear();
        ordersList = l_ModGetAllOrders.data?.orders;

        l_list_ModGetAllOrders = ordersList!.map((orderJson) {
          return orderJson;
        }).toList();

        RxListModUserAllOrders?.value.clear();

        RxListModUserAllOrders?.value = l_list_ModGetAllOrders ?? [];

        RxListModUserProcessingEnrOrders?.clear();
        // RxListModUserProcessingEnrOrders?.value = RxListModUserAllOrders!.value
        //     .where((order) => order.status == OrderStatus.PROCESSING || order.status == Status.OrderEnroute)
        //     .toList();
        RxListModUserProcessingEnrOrders?.value = l_list_ModGetAllOrders ?? [];

        isLoadingAllOrders.value = false; // Hide loading indicator

        // print(l_list_ModGetAllOrders);

        print("Called");
        isLoadingAllOrders.value = false; // Hide loading indicator

        return true;
      } else {
        print("failed");
        isLoadingAllOrders.value = false; // Hide loading indicator

        return false;
      }
    } catch (e) {
      print("Error in fnc_GetAllOrders: $e");
      return false; // You can handle the error as needed
    }
  }

  ////

  bool filterOrderHistoryByStatus() {
    try {
      isLoadingOrderHistory.value = true;

      if (RxListModUserAllOrders != null) {
        final filteredOrders = RxListModUserAllOrders!
            .where((order) => order.status == OrderStatus.PROCESSING || order.status == OrderStatus.CANCELLED)
            .toList();

        RxListModOrderHistory?.clear();
        RxListModOrderHistory?.assignAll(filteredOrders);

        isLoadingOrderHistory.value = false;

        return true; // Filtering and assignment succeeded
      } else {
        isLoadingOrderHistory.value = false;

        return false; // RxListModUserAllOrders is null
      }
    } catch (error) {
      print("Error in filterOrderHistoryByStatus: $error");
      return false; // Error occurred
    }
  }

  bool fncNewOrdersWaitingFilter() {
    try {
      isLoadingPendingNewOrders.value = true;

      if (RxListModUserAllOrders != null) {
        final filteredOrders = RxListModUserAllOrders!
            .where((order) =>
                order.status == OrderStatus.PENDING &&
                order.driverStatus == DriverStatus.WAITING) // U.se the enum value for 'cancelled'
            .toList();
        RxListModOrderPenidngNew?.clear();
        RxListModOrderPenidngNew?.assignAll(filteredOrders);
        isLoadingPendingNewOrders.value = false;
        return true; // Filtering and assignment succeeded
      } else {
        isLoadingPendingNewOrders.value = false;

        return false; // RxListModUserAllOrders is null
      }
    } catch (error) {
      isLoadingPendingOrders.value = false;

      print("Error in filterOrderHistoryByStatus: $error");
      return false; // Error occurred
    }
  }

  bool fncNewOrdersAcceptedFilter() {
    try {
      isLoadingPendingOrders.value = true;

      if (RxListModUserAllOrders != null) {
        final filteredOrders = RxListModUserAllOrders!
            .where((order) =>
                order.status == OrderStatus.PENDING &&
                order.driverStatus == DriverStatus.ACCEPTED) // U.se the enum value for 'cancelled'
            .toList();
        RxListModOrderPenidngNew?.clear();
        RxListModOrderPenidngNew?.assignAll(filteredOrders);
        isLoadingPendingOrders.value = false;
        return true; // Filtering and assignment succeeded
      } else {
        isLoadingPendingOrders.value = false;

        return false; // RxListModUserAllOrders is null
      }
    } catch (error) {
      isLoadingPendingOrders.value = false;

      print("Error in filterOrderHistoryByStatus: $error");
      return false; // Error occurred
    }
  }

  Future<bool> fnc_RefreshAllOrders() async {
    try {
      isLoadingAllOrders.value = true; // Show loading indicator

      ModGetAllOrders l_ModGetAllOrders = await Sl_GetAllOrders().fnc_GetAllorders_apiCall();
      List<Order> l_list_ModGetAllOrders = [];
      List<Order>? ordersList = [];

      if (l_ModGetAllOrders != null) {
        ordersList.clear();
        l_list_ModGetAllOrders.clear();
        RxListModUserAllOrders?.value.clear();
        ordersList = l_ModGetAllOrders.data?.orders;

        l_list_ModGetAllOrders = ordersList!.map((orderJson) {
          return orderJson;
        }).toList();

        RxListModUserAllOrders?.value = l_list_ModGetAllOrders ?? [];
        isLoadingAllOrders.value = false; // Hide loading indicator
        return true;
      } else {
        isLoadingAllOrders.value = false; // Hide loading indicator on failure
        return false;
      }
    } catch (e) {
      isLoadingAllOrders.value = false; // Hide loading indicator on error
      print("Error in fnc_RefreshAllOrders: $e");
      return false;
    }
  }
}
