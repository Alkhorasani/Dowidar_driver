import 'package:dowidardriver/ClassModules/cmFirebaseServices/cmFirebaseServices.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModUserLogin/ModUserLogin.dart';
import 'package:dowidardriver/ServiceLayer/Sl_FirebaseNotifications.dart';
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

    final phone = l_ModUserData.data?.user?.phone ?? '';
    final email = l_ModUserData.data?.user?.email ?? '';
    final status = l_ModUserData.data?.user?.status ?? '';
    final accessToken = l_ModUserData.data?.accessToken ?? '';
    final driverID = l_ModUserData.data?.user?.id ?? '';
    final password = cmGlobalVariables.pbPassword ?? '';
    final fullName = l_ModUserData.data?.user?.fullName ?? '';

    l_SharedPreferences.setString('l_driverPhone', phone);
    l_SharedPreferences.setString('l_driverEmail', email);
    l_SharedPreferences.setString('l_driverStatus', status);
    l_SharedPreferences.setString('l_token', accessToken);
    l_SharedPreferences.setString('l_driverID', driverID);
    l_SharedPreferences.setString('l_driverPasword', password);
    l_SharedPreferences.setString('l_driverfullname', fullName);

    print('User data saved to SharedPreferences:');
    print('  - Phone: $phone');
    print('  - Email: $email');
    print('  - Status: $status');
    print('  - Access Token: ${accessToken.isNotEmpty ? "${accessToken.substring(0, 20)}..." : "EMPTY"}');
    print('  - Driver ID: $driverID');
    print('  - Full Name: $fullName');
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


  Future<void> fncTokenUpdate() async {
    try {
      // First get the Firebase token
      String? firebaseToken = await FirebaseService.getDeviceToken();
      
      if (firebaseToken == null || firebaseToken.isEmpty) {
        throw Exception("Failed to retrieve Firebase notification token");
      }
      
      cmGlobalVariables.pBFirebaseNotificationToken = firebaseToken;
      print('Firebase token retrieved: ${firebaseToken.substring(0, 20)}...');
      
      // Then update the device token on the server
      await Sl_FirebaseNotifications().FncaddUserDevice();
      print('Device token update completed successfully');

    } catch (e, stack) {
      print('Error in fncTokenUpdate: $e');
      print('Stack trace: $stack');
      throw Exception("Token update failed: $e");
    }
  }




  Future<bool> fncBtnOntap_Login() async {
    cmGlobalVariables.pbEmail = phoneController.text;
    cmGlobalVariables.pbPassword = passswordController.text;

    try {
      // First attempt to login
      if (await fnc_Userlogin() == true) {
        // Login successful, now try to update device token
        // Don't fail the entire login if device token update fails
        try {
          await fncTokenUpdate();
          print('Login completed successfully with device token update');
        } catch (tokenError) {
          print("Warning: Device token update failed but login was successful: $tokenError");
          // Log the error but don't prevent the user from logging in
        }
        return true;
      } else {
        print("Login failed - invalid credentials or server error");
        return false;
      }
    } catch (e) {
      print("Error in fncBtnOntap_Login: $e");
      return false;
    }
  }
}
