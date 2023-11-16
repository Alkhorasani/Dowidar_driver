import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModNewOrder/ModNewOrders.dart';
import 'package:dowidardriver/MVVM/Model/ModOrderStatus/ModOrderStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_GetAllOrders.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderAccRej.dart';
import 'package:dowidardriver/ServiceLayer/Sl_OrderStatus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../ServiceLayer/Sl_DriverLocation.dart';
import '../../../ServiceLayer/Sl_OrderDetails.dart';
import '../../Model/ModDriverStatus/ModDriverStatus.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../../Model/ModOrderDetails/ModOrderDetials.dart';
import '../Vm_CommonLayout/Vm_CommonLayout.dart';

class Vm_OrderDetails extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ModOrderDetails?> orderDetails = Rx<ModOrderDetails?>(null);

  RxBool isMethodCash = false.obs;

  String? date;
  String? time;
  String? rawCreatedAt;
  String? TotalCash;
  String? Paymenttype;

  void fnc_processOrderDetails() {
    rawCreatedAt = orderDetails.value?.data?.order?.createdAt;

    if (rawCreatedAt != null) {
      DateTime createdAt = DateTime.parse(rawCreatedAt!);
      date = DateFormat('dd/MM/yy').format(createdAt);
      time = DateFormat('hh:mm a').format(createdAt);
    }

    Paymenttype = orderDetails.value?.data?.order?.paymentType(orderDetails.value?.data?.order?.paymentHistories);

    if (Paymenttype != null) {
      isMethodCash.isTrue;
    } else {
      isMethodCash.isFalse;
    }

    TotalCash = orderDetails.value?.data?.order?.getTotalPayment(orderDetails.value?.data?.order?.paymentHistories);

    cmGlobalVariables.pbUserID = orderDetails.value?.data?.order?.userId;
  }

  Future<void> fnc_OrderDetails() async {
    try {
      isLoading.value = true; // Show loading indicator

      final orderData = await Sl_OrderDetails().fnc_OrderDetails();

      if (orderData != null && orderData.data != null) {
        // Update the orderDetails with the fetched data
        orderDetails.value = orderData;
        isLoading.value = false; // Hide loading indicator
      } else {
        isLoading.value = false; // Hide loading indicator on failure
      }
    } catch (e) {
      print("Error in fnc_OrderDetails: $e");
      isLoading.value = false; // Hide loading indicator on error
    }
  }
}
