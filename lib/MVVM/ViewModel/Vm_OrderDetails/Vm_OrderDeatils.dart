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
  List<Variation>? allVariations = [];


  RxBool isMethodCash = false.obs;

  RxBool hasVariations = false.obs;


  String? date;
  String? time;
  String? rawCreatedAt;
  String? TotalCash;
  String? Paymenttype;
  String? Resturentname;

  void fnc_processOrderDetails() {
    rawCreatedAt = orderDetails.value?.data?.order?.createdAt;
    String? restaurantName = orderDetails.value?.data?.order?.restaurant?.name.toString();
    int? lastDotIndex = restaurantName?.lastIndexOf('.');

    // Extract the substring after the last dot
    String? Resturentname = lastDotIndex != -1 ? restaurantName?.substring(lastDotIndex! + 1) : restaurantName;

    if (rawCreatedAt != null) {
      DateTime createdAt = DateTime.parse(rawCreatedAt!);
      date = DateFormat('dd/MM/yy').format(createdAt);
      time = DateFormat('hh:mm a').format(createdAt);
    }

    try {
      PaymentMethodName? paymentMethodName =
          orderDetails.value?.data?.order?.paymentType(orderDetails.value?.data?.order?.paymentHistories);

      if (paymentMethodName != null) {
        String paymentTypeString = paymentMethodName.name.toLowerCase();

        if (paymentTypeString.contains("cash")) {
          Paymenttype = "Cash";
          isMethodCash.value = false;
        } else if (paymentTypeString.contains("wallet")) {
          Paymenttype = "Wallet";
          isMethodCash.value = true;


        }

        else if( paymentTypeString.contains("wallet cash") ){
          Paymenttype = paymentTypeString;


        }
        else {
          // Handle other cases if needed
          Paymenttype = paymentTypeString;
        }
      }
    } catch (e , Stack) {
      // Handle the exception here
      print([Stack]);
      // You might want to set a default value for Paymenttype or take other appropriate actions.
    }

    // Paymenttype = orderDetails.value?.data?.order?.paymentType(orderDetails.value?.data?.order?.paymentHistories);
    print(" Payment Type: $Paymenttype");

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
        for (final item in orderDetails.value!.data!.order!.items!) {
          if (item.variationGroups != null) {
            for (final group in item.variationGroups!) {
              allVariations?.addAll(group.variations!);
            }
          }
        }
        if (allVariations != null) {
          hasVariations.value = true;
        }
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
