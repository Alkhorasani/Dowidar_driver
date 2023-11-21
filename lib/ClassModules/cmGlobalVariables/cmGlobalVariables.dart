import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../MVVM/Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../../MVVM/Model/ModUserLogin/ModDriverLocalData.dart';
import '../../MVVM/Model/ModUserLogin/ModUserLogin.dart';

class cmGlobalVariables {
  static String? pbEmail;
  static String? pbPassword;

  static String? Pb_Token;
  static ModUserData? Pb_ModUserData;
  static ModDriverLocalData? Pb_ModDriverLocalData;
  static double? pBUserLongitude ;
  static double? pBUserLatitude ;
  static bool? pBisAccepted;
  static int? pBOrderId;
  static int? pBOntapOrderId;
  static int? pBOrderStatusId;
  static String? pBOrderStatus;

  static bool? pBisSwitch_onOff;
  static String? pbDriberID;
  static String? pbUserID;
  static String? pBFirebaseNotificationToken;

  static int? pBChatOrderId;
  static String? pBChatReciverId;



// static List<Datum> ? pB_list_ModGetAllOrders;


}
