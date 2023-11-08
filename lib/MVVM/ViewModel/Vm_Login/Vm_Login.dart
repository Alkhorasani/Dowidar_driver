import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModUserLogin/ModUserLogin.dart';
import 'package:dowidardriver/ServiceLayer/Sl_UserLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ModUserLogin/ModDriverLocalData.dart';

class Vm_Login extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passswordController = TextEditingController();
  RxBool isPassword_secure = false.obs;

  RxBool get boolSecurePassword_wid {
    return isPassword_secure;
  }

  set boolSecurePassword_wid(RxBool value) {
    isPassword_secure = value;
  }

  bool fieldsValidate = false;

  ModUserData? l_ModUSerData;

  fncSetuserData(ModUserData l_ModUserData) async {
    final l_SharedPreferences = await SharedPreferences.getInstance();

    l_SharedPreferences.setString('l_driverPhone', l_ModUserData.data?.user?.phone ?? '');
    l_SharedPreferences.setString('l_driverEmail', l_ModUserData.data?.user?.email ?? '');
    l_SharedPreferences.setString('l_driverStatus', l_ModUserData.data?.user?.status ?? '');
    l_SharedPreferences.setString('l_token', l_ModUserData.data?.accessToken ?? '');
    l_SharedPreferences.setString('l_driverID', l_ModUserData.data?.user?.id ?? '');
    l_SharedPreferences.setString('l_driverPasword', cmGlobalVariables.pbPassword ?? '');
    l_SharedPreferences.setString('l_driverfullname', l_ModUserData.data?.user?.fullName ?? '');
  }

  fncGetUserData() async {
    final l_SharedPreferences = await SharedPreferences.getInstance();

    final email = l_SharedPreferences.getString('l_driverEmail') ?? '';
    final phone = l_SharedPreferences.getString('l_driverPhone') ?? '';
    final status = l_SharedPreferences.getString('l_driverStatus') ?? '';
    final accessToken = l_SharedPreferences.getString('l_token') ?? '';
    final id = l_SharedPreferences.getString('l_driverID') ?? '';
    final password = l_SharedPreferences.getString('l_driverPasword') ?? '';
    final fullname = l_SharedPreferences.getString('l_driverfullname') ?? '';
    cmGlobalVariables.Pb_Token = accessToken;
    ModDriverLocalData localData = ModDriverLocalData(
      email: email,
      phone: phone,
      status: status,
      accessToken: accessToken,
      id: id,
      password: password,
      fullname: fullname,
    );

    cmGlobalVariables.Pb_ModDriverLocalData = localData;
    print(cmGlobalVariables.Pb_ModDriverLocalData);
  }

  Future<bool> fnc_Userlogin() async {
    try {
      ModUserData l_ModUserData = await Sl_UserLogin().fnc_Userlogin_apiCall();

      if (l_ModUserData != null) {
        // cmGlobalVariables.Pb_Token = l_ModUserData.data?.accessToken;
        print(cmGlobalVariables.Pb_Token);
        cmGlobalVariables.Pb_ModUserData = l_ModUserData;

        await fncSetuserData(l_ModUserData);
        await fncGetUserData();

        print("User Login");
        return true;
      } else {
        print("Login failed");
        return false;
      }
    } catch (e) {
      print("Error in fnc_Userlogin: $e");
      return false; // You can handle the error as needed
    }
  }

  Future<bool> fncBtnOntap_Login() async {
    cmGlobalVariables.pbEmail = phoneController.text;
    cmGlobalVariables.pbPassword = passswordController.text;

    try {
      if (await fnc_Userlogin() == true) {
        return true;
      }
    } catch (e) {
      print("Error in fncBtnOntap_Login: $e");
    }
    return false;
  }
}
