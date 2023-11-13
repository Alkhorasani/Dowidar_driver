
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cm_HandleDeepLink {

  handleDeepLink({BuildContext? context, required String deeplink, dynamic payLoad}) {


    // switch (deeplink){
    //   case Routes.productDScreen:
    //     homeState.getServiceProductDetail(payLoad.id);
    //     Get.to(() =>  const DetailScreen());
    //     break;
    //   case Routes.categoryDScreen:
    //     homeState.getCategoryHome(payLoad.id);
    //     Get.to(() => CategoryDetail(title: '',));
    //     break;
    //   case Routes.orderDScreen:
    //     userState.getOrderDetail(payLoad);
    //     Get.to(()=> const OrderTracking(
    //       isFromCart: false,
    //       isFromDashboard: true,
    //     ));
    //     break;
    //   case Routes.discountDType:
    //     Clipboard.setData(ClipboardData(
    //         text: payLoad.title));
    //     HapticFeedback.heavyImpact();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
    //       behavior: SnackBarBehavior.floating,
    //       content: TitleText(
    //         StringConst.copyCouponsText.tr,
    //       ),
    //     ));
    //     break;
    //   case 'service':
    //     Get.toNamed(Routes.fDeliveryScreen);
    //     // state.loadServicesDetailFromCache(
    //     //     services[index].serviceCode!);
    //     filterProvider.getAllFilterCategory(payLoad.id);
    //     // filterProvider.serviceId = payLoad.id;
    //     // homeState.serviceCode = payLoad.id;
    //     homeState.serviceCall(
    //         locationCode: homeState.servicesTypeDataList.first.locationCode!,
    //         serviceId: payLoad.id,
    //         serviceType: '');
    //     break;
    //   default:
    //     LoggerManager.warn('$deeplink type of banner is not handled yet.');
    // }
  }
}