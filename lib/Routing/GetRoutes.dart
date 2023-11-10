
import 'package:dowidardriver/MVVM/View/Vw_Chat/Vw_Chat.dart';
import 'package:dowidardriver/MVVM/View/Vw_CommonLayout/Vw_CommonLayout.dart';
import 'package:dowidardriver/MVVM/View/Vw_OrderDetails/Vw_OrderDetails.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../MVVM/View/View_Login/Vw_Login.dart';
import '../MVVM/View/Vw_Home/Vw_Home.dart';
import '../MVVM/View/Vw_OrderHistory/Vw_OrderHistory.dart';
import '../MVVM/View/Vw_Profile/Vw_Profile.dart';
import '../MVVM/View/Vw_Settings/Vw_Settings.dart';
import '../MVVM/View/Vw_Splash/Vw_splashscreen.dart';
import 'AppRoutes.dart';

class GetAppRoutes {
  static List<GetPage> Fnc_GetPages() {
    return [
      GetPage(name: AppRoutes.initialRoute, page: () => Vw_splashScreen(), transition: Transition.native),
      GetPage(name: AppRoutes.vwLogin, page: () => Vw_Login(), transition: Transition.native),
      GetPage(name: AppRoutes.vwHome, page: () => Vw_Home(), transition: Transition.native),
      GetPage(name: AppRoutes.vwProfile, page: () => VwUserProfile(), transition: Transition.native),
      GetPage(name: AppRoutes.vwSettings, page: () => Vw_Settings(), transition: Transition.native),
      GetPage(name: AppRoutes.vwOrderHistory, page: () => Vw_OrderHistory(), transition: Transition.native),
      GetPage(name: AppRoutes.vwCommonLayout, page: () => CommonLayout(), transition: Transition.native),
      GetPage(name: AppRoutes.vwChat, page: () => ChatView(), transition: Transition.native),
      GetPage(name: AppRoutes.vwOrderDetails, page: () => Vw_OrderDetails(), transition: Transition.native),
    ];
  }
}
