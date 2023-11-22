import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vm_Settings extends GetxController {
  Future<void> fncClearCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('l_driverPhone');
    sharedPreferences.remove('l_driverEmail');
    sharedPreferences.remove('l_driverStatus');
    sharedPreferences.remove('l_token');
    sharedPreferences.remove('l_driverID');
    sharedPreferences.remove('l_driverPasword');
    sharedPreferences.remove('l_driverfullname');
    sharedPreferences.remove('deviceName');
    sharedPreferences.remove('deviceID');
    sharedPreferences.remove('os');
    sharedPreferences.remove('osVersion');
  }

  fnc_ClearData() async {
    await fncClearCache();

    cmGlobalVariables.pbEmail = null;
    cmGlobalVariables.pbPassword = null;

    cmGlobalVariables.Pb_Token = null;
    cmGlobalVariables.Pb_ModUserData = null;
    cmGlobalVariables.Pb_ModDriverLocalData = null;
    cmGlobalVariables.pBUserLongitude = null;
    cmGlobalVariables.pBUserLatitude = null;
    cmGlobalVariables.pBisAccepted = null;
    cmGlobalVariables.pBOrderId = null;
    cmGlobalVariables.pBOntapOrderId = null;
    cmGlobalVariables.pBOrderStatusId = null;
    cmGlobalVariables.pBOrderStatus = null;

    cmGlobalVariables.pBisSwitch_onOff = null;
    cmGlobalVariables.pbDriberID = null;
    cmGlobalVariables.pbUserID = null;
    cmGlobalVariables.pBFirebaseNotificationToken = null;
  }

  // Future logout() async {
  //   String accessToken = await SharedPreferencesHelper.instance
  //       .getString(SharedPreferencesHelper.instance.accessToken);
  //   isLogging = true;
  //   var response;
  //   try {
  //     response = await apiRepository.logout(accessToken);
  //     print(response);
  //     await sharedPreferenceHelper.setString(sharedPreferenceHelper.accessToken,
  //         userModel.data?.accessToken ?? '');
  //     await sharedPreferenceHelper.setString(
  //         sharedPreferenceHelper.userData, userModelToJson(userModel));
  //     isLogging = false;
  //     notifyListeners();
  //     return response;
  //   } catch (e, stack) {
  //     isLogging = false;
  //     notifyListeners();
  //     print('Error: $e, $stack');
  //     return response;
  //   }
  // }


}
