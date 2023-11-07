import 'package:dowidardriver/ServiceLayer/Sl_GetAllOrders.dart';
import 'package:get/get.dart';

import '../../../testmodel.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';

class Vm_Home extends GetxController {
  RxBool isActiveSwitch = false.obs;

  RxInt selectedIndex = 0.obs;
  RxDouble iconSize = 28.0.obs;


  List<PopularDietsModel> l_PopularDiets = [];

  void getPopulerdiets() {
    l_PopularDiets = PopularDietsModel.getPopularDiets();
  }
}
