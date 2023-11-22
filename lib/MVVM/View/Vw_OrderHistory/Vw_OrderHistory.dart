import 'package:dowidardriver/ClassModules/cm_StringConstants/cm_StringConstantsVwCommomLayout.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../ClassModules/AppImages/cmGlobal_AppImages.dart';
import '../../../ClassModules/cm_StringConstants/cm_StringConstantsVwHome.dart';
import '../../../CustomWidgets/ArabicTextField.dart';
import '../../../Routing/AppRoutes.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../../ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';
import '../../ViewModel/Vm_Login/Vm_Login.dart';

class Vw_OrderHistory extends StatefulWidget {
  const Vw_OrderHistory({super.key});

  @override
  State<Vw_OrderHistory> createState() => _Vw_OrderHistoryState();
}

class _Vw_OrderHistoryState extends State<Vw_OrderHistory> {
  final Vm_CommonLayout l_Vm_CommonLayout = Get.find<Vm_CommonLayout>();
  final Vm_Home l_Vm_Home = Get.find<Vm_Home>();

  @override
  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double G_height, G_width) {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            // Navigate back to the second screen
            return false; // Prevent the app from being closed
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Text(
                "${'${cm_StringConstantsVwCommomLayout.strOrdersHistory}'.tr}",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                        fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: .5)),
              ),
              centerTitle: true,
            ),
            body: Container(
              height: G_height,
              width: G_width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: G_height * 0.02,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              l_Vm_Home.isSelectedred.value = false;
                              l_Vm_Home.isSelectedblue.value = true;
                              l_Vm_Home.isSelectedfreen.value = false;

                              Get.dialog(
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                barrierDismissible: false,
                              );

                              await l_Vm_Home.fncfilterProcessing();
                              Get.back();

                              l_Vm_CommonLayout.RxListModOrderHistory?.refresh();
                              print('Container tapped');
                            },
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                  color: l_Vm_Home.isSelectedblue.value == true
                                      ? Colors.blue
                                      : Colors.blue.withOpacity(0.3), // Set the background color to white

                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "${'${cm_StringConstantsVwHome.strBlueProcessing}'.tr}",
                                      style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Colors.white,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                    )),
                              );
                            }),
                          ),
                          GestureDetector(
                            onTap: () async {
                              //await l_Vm_Home.fncTokenUpdate();
                              l_Vm_Home.isSelectedred.value = true;
                              l_Vm_Home.isSelectedfreen.value = false;
                              l_Vm_Home.isSelectedblue.value = false;

                              Get.dialog(
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                barrierDismissible: false,
                              );

                              await l_Vm_Home.fncfilterCancelled();
                              Get.back();
                              l_Vm_CommonLayout.RxListModOrderHistory?.refresh();
                              print('Container tapped');
                            },
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      l_Vm_Home.isSelectedred.value == true ? Colors.red : Colors.red.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "${'${cm_StringConstantsVwHome.strRedCancelled}'.tr}",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: G_height * 0.01),
                  SizedBox(height: G_height * 0.01),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await l_Vm_CommonLayout.filterOrderHistoryByStatus();
                        l_Vm_CommonLayout.RxListModOrderHistory?.refresh();
                        l_Vm_Home.isSelectedblue.value = false;
                        l_Vm_Home.isSelectedred.value = false;
                      },
                      child: Obx(() {
                        if (l_Vm_CommonLayout.RxListModOrderHistory!.isEmpty ||
                            l_Vm_CommonLayout.RxListModOrderHistory == null) {
                          return Center(
                            child: Text(
                              "${'${cm_StringConstantsVwHome.strYoudont_haveOrderhistory}'.tr}",
                              style: GoogleFonts.ubuntu(
                                textStyle:
                                    const TextStyle(fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: l_Vm_CommonLayout.RxListModOrderHistory!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: G_height * 0.02,
                          ),
                          padding: EdgeInsets.only(left: G_width * 0.03, right: G_width * 0.03),
                          itemBuilder: (context, index) {
                            final order = l_Vm_CommonLayout.RxListModOrderHistory![index];
                            final items = order.items;
                            final resturent = order.restaurant;
                            final status = order.status;
                            final user = order.user;

                            // Define the color based on the order status
                            Color tileColor;
                            if (order.status == OrderStatus.CANCELLED) {
                              tileColor = Colors.red.withOpacity(0.3);
                            } else if (order.status == OrderStatus.PROCESSING) {
                              tileColor = Colors.lightBlue.withOpacity(0.3);
                              // } else if (order.status == DatumStatus.PENDING) {
                              //   tileColor = Colors.green.withOpacity(0.3);
                            } else {
                              tileColor = Colors.white; // Default color for other statuses
                            }

                            return Container(
                              height: G_height * 0.20,
                              decoration: BoxDecoration(
                                color: tileColor, // Set the determined color
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff1D1617).withOpacity(0.07),
                                    offset: const Offset(0, 10),
                                    blurRadius: 40,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${'${cm_StringConstantsVwHome.strOrderNO}:'.tr}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          order.orderNo.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${'${cm_StringConstantsVwHome.strStatus}:'.tr}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "${status != null ? status.toString().split('.').last : ''}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${'${cm_StringConstantsVwHome.strResturent}:'.tr}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(() {
                                            if (l_Vm_Home.isArabic.value == true) {
                                              return CustomRestaurantNameText(
                                                restaurantName: order.restaurant!.arName.toString(),
                                              );
                                            }
                                            return Container(
                                              child: Text(
                                                order.restaurant!.name.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${'${cm_StringConstantsVwHome.CreatedAt}'.tr}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "${DateFormat('hh:mm a').format(order.createdAt!)}:${DateFormat('dd/MM').format(order.createdAt!)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${'${cm_StringConstantsVwHome.strAddress}:'.tr}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black45,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              order.restaurant!.address.toString(),
                                              maxLines: 4,
                                              // softWrap: true,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        l_Vm_Home.isSelectedred.value = false;
        l_Vm_Home.isSelectedblue.value = false;
        l_Vm_Home.isSelectedfreen.value = false;
        //when tap anywhere on screen keyboard dismiss
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              //Get device's screen height and width.
              double height = MediaQuery.of(context).size.height;
              double width = MediaQuery.of(context).size.width;

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
