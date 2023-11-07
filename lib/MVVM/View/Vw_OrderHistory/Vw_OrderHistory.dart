import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ClassModules/AppImages/cmGlobal_AppImages.dart';
import '../../../Routing/AppRoutes.dart';
import '../../ViewModel/Vm_Login/Vm_Login.dart';

class Vw_OrderHistory extends StatefulWidget {
  const Vw_OrderHistory({super.key});

  @override
  State<Vw_OrderHistory> createState() => _Vw_OrderHistoryState();
}

class _Vw_OrderHistoryState extends State<Vw_OrderHistory> {
  @override
  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
      return WillPopScope(
        onWillPop: () async {
          // Navigate back to the second screen

          Get.toNamed(AppRoutes.vwCommonLayout);
          return false; // Prevent the app from being closed
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,

              title: Text(
                "Order History",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        //fontWeight: FontWeight.w600,
                        letterSpacing: .5)),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [],
            )),
      );
    }

    return GestureDetector(
      onTap: () {
        //when tap anywhere on screen keyboard dismiss
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              //Get device's screen height and width.
              double height = constraints.maxHeight;
              double width = constraints.maxWidth;

              if (width >= 300 && width < 500) {
                return _WidgetportraitMode(height, width);
              } else {
                return _WidgetportraitMode(height, width);
              }
            },
          );
        },
      ),
    );
  }
}
