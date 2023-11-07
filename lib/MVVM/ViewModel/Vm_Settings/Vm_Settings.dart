import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:get/get.dart';

class Vm_Settings extends GetxController {

  fnc_ClearData(){

    cmGlobalVariables.Pb_ModUserData = null;
    cmGlobalVariables.pbEmail = null;
    cmGlobalVariables.pbPassword = null;
    cmGlobalVariables.Pb_Token =null;
    cmGlobalVariables.Pb_ModDriverLocalData = null;

  }

}