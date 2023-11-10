import 'package:dowidardriver/MVVM/Model/ModNewOrder/ModNewOrders.dart';
import 'package:dowidardriver/MVVM/Model/ModOrderStatus/ModOrderStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_GetAllOrders.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderAccRej.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderStatus.dart';
import 'package:get/get.dart';

import '../../../ServiceLayer/Sl_DriverLocation.dart';
import '../../Model/ModDriverStatus/ModDriverStatus.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../Vm_CommonLayout/Vm_CommonLayout.dart';

class Vm_Home extends GetxController {
  RxBool isActiveSwitch = false.obs;

  RxBool isLoadingPendingOrders = false.obs;
  RxBool isLoadingOrderHistory = false.obs;
  RxInt selectedIndex = 0.obs;
  RxDouble iconSize = 28.0.obs;
  RxBool isLoadingAccOrRej = false.obs;
  RxBool isSelectedred = false.obs;
  RxBool isSelectedblue = false.obs;
  RxBool isSelectedfreen = false.obs;


  final Vm_CommonLayout l_Vm_CommonLayout = Get.find<Vm_CommonLayout>();



  Future<bool> fnc_OrderAccRej() async {
    try {
      isLoadingAccOrRej.value = true; // Show loading indicator

      ModNewOrders l_ModNewOrders = await Sl_OrderAccRej().fnc_OrderAccRej();

      if (l_ModNewOrders != null) {
        isLoadingAccOrRej.value = false; // Hide loading indicator

        // print(l_list_ModGetAllOrders);

        print("Called");
        isLoadingAccOrRej.value = false; // Hide loading indicator

        return true;
      } else {
        print("failed");
        isLoadingAccOrRej.value = false;
        return false;
      }
    } catch (e) {
      print("Error in fnc_GetAllOrders: $e");
      return false; // You can handle the error as needed
    }
  }

  Future<bool> fnc_UpdateOrderStatus() async {
    try {
      isLoadingAccOrRej.value = true; // Show loading indicator

      ModOrderStatus l_ModOrderStatus = await Sl_OrderStatus().fnc_OrderStatus();

      if (l_ModOrderStatus != null) {
        isLoadingAccOrRej.value = false; // Hide loading indicator

        // print(l_list_ModGetAllOrders);

        print("Called");
        isLoadingAccOrRej.value = false; // Hide loading indicator

        return true;
      } else {
        print("failed");
        isLoadingAccOrRej.value = false;
        return false;
      }
    } catch (e) {
      print("Error in fnc_GetAllOrders: $e");
      return false; // You can handle the error as needed
    }
  }

  Future<bool> fnc_UpdateDriverLocation() async {
    try {
      ModDriverLocation l_ModDriverLocation = await Sl_DriverLocation().fnc_driverLoction();

      if (l_ModDriverLocation != null) {
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




  Future<bool> fncfilterCancelled() async {
    try {
      isLoadingOrderHistory.value = true;
        await l_Vm_CommonLayout.fnc_GetAllOrders();
      if ( l_Vm_CommonLayout. RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout. RxListModUserAllOrders!
            .where((order) => order.status == DatumStatus.CANCELLED) // Use the enum value for 'cancelled'
            .toList();

        l_Vm_CommonLayout. RxListModUserAllOrders?.assignAll(filteredOrders);
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

  Future<bool> fncfilterPending() async {
    try {
      await l_Vm_CommonLayout.fnc_GetAllOrders();

      isLoadingPendingOrders.value = true;

      if (l_Vm_CommonLayout. RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout. RxListModUserAllOrders!
            .where((order) => order.status == DatumStatus.PENDING) // U.se the enum value for 'cancelled'
            .toList();
        l_Vm_CommonLayout. RxListModUserAllOrders?.assignAll(filteredOrders);
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

  Future<bool> fncfilterProcessing() async {
    try {
      await l_Vm_CommonLayout.fnc_GetAllOrders();

      isLoadingPendingOrders.value = true;

      if (l_Vm_CommonLayout. RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout. RxListModUserAllOrders!
            .where((order) => order.status == DatumStatus.PROCESSING) // U.se the enum value for 'cancelled'
            .toList();
        l_Vm_CommonLayout. RxListModUserAllOrders?.assignAll(filteredOrders);
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





}
