import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/Enum/EnumStatus.dart';
import 'package:dowidardriver/MVVM/Model/ModNewOrder/ModNewOrders.dart';
import 'package:dowidardriver/MVVM/Model/ModOrderDetails/ModOrderDetials.dart';
import 'package:dowidardriver/MVVM/Model/ModOrderStatus/ModOrderStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_DriverStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_GetAllOrders.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderAccRej.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderDetails.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderStatus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ClassModules/cmFirebaseServices/cmFirebaseServices.dart';
import '../../../ServiceLayer/Sl_DriverLocation.dart';
import '../../../ServiceLayer/Sl_FirebaseNotifications.dart';
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
  RxBool isSelectedYellow = false.obs;
  RxBool isSelectedPurple= false.obs;
  RxBool isSelectedAll= false.obs;


  RxBool isArabic = false.obs;


  RxList<Order>? RxListModUserOrderDetails = <Order>[].obs;

  final Vm_CommonLayout l_Vm_CommonLayout = Get.find<Vm_CommonLayout>();

  ModOrderDetails? orderDetails; // Declare the model outside the method

   void fncresetColorSelections() {
    isSelectedred.value = false;
   isSelectedblue.value = false;
    isSelectedfreen.value = false;
    isSelectedPurple.value = false;
    isSelectedYellow.value = false;
    isSelectedAll.value = false;
  }

  Future<bool> fnc_OrderDetails() async {
    try {
      orderDetails = await Sl_OrderDetails().fnc_OrderDetails();

      if (orderDetails != null && orderDetails?.data != null) {
        return true; // Successfully fetched data
      } else {
        print("Failed");
        return false; // Data not available or other failure cases
      }
    } catch (e) {
      print("Error in fnc_OrderDetails: $e");
      return false; // Handle the error case
    }
  }

  // Future<bool> fnc_OrderAccRej() async {
  //   try {
  //     isLoadingAccOrRej.value = true; // Show loading indicator
  //
  //     ModNewOrders l_ModNewOrders = await Sl_OrderAccRej().fnc_OrderAccRej();
  //
  //     if (l_ModNewOrders != null) {
  //       isLoadingAccOrRej.value = false; // Hide loading indicator
  //
  //       // print(l_list_ModGetAllOrders);
  //
  //       print("Called");
  //       isLoadingAccOrRej.value = false; // Hide loading indicator
  //
  //       return true;
  //     } else {
  //       print("failed");
  //       isLoadingAccOrRej.value = false;
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error in fnc_GetAllOrders: $e");
  //     return false; // You can handle the error as needed
  //   }
  // }

  Future<bool> fnc_OrderAccRej() async {
    try {
      isLoadingAccOrRej.value = true; // Show loading indicator

      // Call the asynchronous function to perform the order acceptance/rejection
      bool success = await Sl_OrderAccRej().fnc_OrderAccRej();

      // Hide loading indicator
      isLoadingAccOrRej.value = false;

      return success;
    } catch (e) {
      print("Error in fnc_OrderAccRej: $e");
      isLoadingAccOrRej.value = false;
      return false; // You can handle the error as needed
    }
  }


  Future<bool> fnc_UpdateDriverStatus() async {
    try {
      final l_SharedPreferences = await SharedPreferences.getInstance();
      final id = l_SharedPreferences.getString('l_driverID') ?? '';
      cmGlobalVariables.pbDriberID = id;
      bool success = await Sl_DriverStatus().fnc_driverStatus();
      return success;
    } catch (e) {
      print("Error in fnc_driverStatus: $e");
      isLoadingAccOrRej.value = false;
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
      if (l_Vm_CommonLayout.RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout.RxListModUserAllOrders!
            .where((order) => order.status == OrderStatus.CANCELLED) // Use the enum value for 'cancelled'
            .toList();
        l_Vm_CommonLayout.RxListModOrderHistory?.clear();

        l_Vm_CommonLayout.RxListModOrderHistory?.assignAll(filteredOrders);
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

  Future<bool> fncfilterEnroute() async {
    try {
      await l_Vm_CommonLayout.fnc_GetAllOrders();

      isLoadingPendingOrders.value = true;

      if (l_Vm_CommonLayout.RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout.RxListModUserAllOrders!
            .where((order) => order.status == OrderStatus.Enroute) // U.se the enum value for 'cancelled'
            .toList();
        l_Vm_CommonLayout.RxListModUserProcessingEnrOrders?.assignAll(filteredOrders);
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

      if (l_Vm_CommonLayout.RxListModUserAllOrders != null) {
        final filteredOrders = l_Vm_CommonLayout.RxListModUserAllOrders!
            .where((order) => order.status == OrderStatus.PROCESSING) // U.se the enum value for 'cancelled'
            .toList();

        l_Vm_CommonLayout.RxListModOrderHistory?.clear();
        l_Vm_CommonLayout.RxListModUserProcessingEnrOrders?.assignAll(filteredOrders);
        l_Vm_CommonLayout.RxListModOrderHistory?.assignAll(filteredOrders);
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



  Future<void> fncTokenUpdate() async {
    try {

      cmGlobalVariables.pBFirebaseNotificationToken =  await FirebaseService.getDeviceToken();
      await Sl_FirebaseNotifications().FncaddUserDevice();

    } catch (e, stack) {
      throw Exception([e, stack]);
    }
  }


}
