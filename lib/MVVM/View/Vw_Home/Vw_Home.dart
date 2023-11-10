import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_Login/Vm_Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmanager/workmanager.dart';

import '../../../CustomWidgets/CustomNavigation_Bar.dart';
import '../../Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../../ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';

class Vw_Home extends StatefulWidget {
  const Vw_Home({super.key});

  @override
  State<Vw_Home> createState() => _Vw_HomeState();
}

class _Vw_HomeState extends State<Vw_Home> {
  @override
  final Vm_Home l_Vm_Home = Get.put(Vm_Home());
  final Vm_CommonLayout l_Vm_CommonLayout = Get.find<Vm_CommonLayout>();

  @override
  void initState() {
    // TODO: implement initState
    l_Vm_Home.getPopulerdiets();

    final Vm_Login l_Vm_Login = Get.put(Vm_Login());
    l_Vm_Login.fncGetUserData();

    l_Vm_CommonLayout.fnc_GetAllOrders();
    l_Vm_CommonLayout.fncPendingOrderFilter();

    print('Latitude: ${cmGlobalVariables.pBUserLatitude}, Longitude:  ${cmGlobalVariables.pBUserLatitude}');
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double G_height, double G_width) {
      return DefaultTabController(
        length: 2, // Number of tabs
        child: WillPopScope(
          onWillPop: () async {
            return false; // Prevent the app from being closed
          },
          child: Scaffold(
            //  bottomNavigationBar: CustomBottomNavigationBar(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Home",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                        fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: .5)),
              ),
              centerTitle: true,

              backgroundColor: Colors.white,
              // You may want to set this to false if you don't want the title centered
              elevation: 0.0,
              bottom: TabBar(
                onTap: (int tabindex) async {
                  if (tabindex == 0) {
                    await l_Vm_CommonLayout.fnc_GetAllOrders();
                  } else if (tabindex == 1) {
                    await l_Vm_CommonLayout.fncPendingOrderFilter();
                  }
                },
                enableFeedback: true,
                dividerColor: Colors.deepOrange,
                labelStyle: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                labelPadding: EdgeInsets.all(3),
                // TabBar for two tabs

                indicatorWeight: 6,

                tabs: [
                  Tab(text: "Current Orders"),
                  Tab(text: "New Orders"),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: G_height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Status',
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Obx(() {
                        return GlowSwitch(
                          onChanged: (value) async {
                            if (value) {
                              print("Switch on");

                              Workmanager().registerOneOffTask(
                                "get_user_location_task",
                                "get_user_location", // Name of the task
                              );

                              Get.dialog(
                                const Center(
                                  child:
                                      CircularProgressIndicator(), // Replace with your desired loading indicator widget
                                ),
                                barrierDismissible: false,
                              );

                              bool isCall = await l_Vm_Home.fnc_UpdateDriverLocation();
                              Get.back(); // Close the loading indicator dialog

                              if (isCall) {
                                print("Api called");
                                Get.snackbar(
                                  "Alert",
                                  "",
                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                  icon: const Icon(Icons.check_circle, color: Colors.deepOrange),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.all(16),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  borderColor: Colors.white,
                                  messageText: const Text(
                                    "Location Live",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              } else {
                                Get.snackbar(
                                  "Alert",
                                  "",
                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                  icon: const Icon(Icons.error_outline, color: Colors.redAccent),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.all(16),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  borderColor: Colors.white,
                                  messageText: const Text(
                                    "Error",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }

                              l_Vm_Home.isActiveSwitch.value = value;
                            } else {
                              l_Vm_Home.isActiveSwitch.value = value;

                              Workmanager().cancelByUniqueName("get_user_location_task");
                              Get.snackbar(
                                "Alert",
                                "",
                                backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                icon: const Icon(Icons.error_outline, color: Colors.redAccent),
                                duration: const Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP,
                                margin: const EdgeInsets.all(16),
                                borderRadius: 10,
                                borderWidth: 1,
                                borderColor: Colors.white,
                                messageText: const Text(
                                  "Location Off",
                                  style: TextStyle(color: Colors.black),
                                ),
                              );

                              print("Switch off");
                            }
                          },
                          value: l_Vm_Home.isActiveSwitch.value,
                          activeColor: Colors.deepOrange.withOpacity(0.6),
                          blurRadius: 4,
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    // TabBarView for content corresponding to the tabs
                    children: [
                      // New Orders Tab
                      Container(
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

                                         l_Vm_Home.fncfilterCancelled();
                                        l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                        print('Container tapped');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Red = Cancelled',
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        l_Vm_Home.fncfilterProcessing();
                                        l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                        print('Container tapped');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.3), // Set the background color to white

                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Blue = Processing',
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        l_Vm_Home.fncfilterPending();
                                        l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                        print('Container tapped');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.3), // Set the background color to white

                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Green = Pending',
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: G_height * 0.01),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await l_Vm_CommonLayout.fnc_RefreshAllOrders();
                                  l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                },
                                child: Obx(() {
                                  if (l_Vm_CommonLayout.isLoadingAllOrders.isTrue) {
                                    // Show a loading indicator
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    if (l_Vm_CommonLayout.RxListModUserAllOrders == null ||
                                        l_Vm_CommonLayout.RxListModUserAllOrders!.isEmpty) {
                                      // Show "List is empty" message
                                      return Center(
                                        child: Text(
                                          "You don't have any current orders",
                                          style: GoogleFonts.ubuntu(
                                            textStyle: const TextStyle(
                                                fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return ListView.separated(
                                        itemCount: l_Vm_CommonLayout.RxListModUserAllOrders!.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) => SizedBox(
                                          height: G_height * 0.02,
                                        ),
                                        padding: EdgeInsets.only(left: G_width * 0.03, right: G_width * 0.03),
                                        itemBuilder: (context, index) {
                                          final order = l_Vm_CommonLayout.RxListModUserAllOrders![index];
                                          final items = order.items;
                                          final resturent = order.restaurant;
                                          final status = order.status;
                                          final user = order.user;

                                          // Define the color based on the order status
                                          Color tileColor;
                                          if (order.status == DatumStatus.CANCELLED) {
                                            tileColor = Colors.red.withOpacity(0.3);
                                          } else if (order.status == DatumStatus.PROCESSING) {
                                            tileColor = Colors.lightBlue.withOpacity(0.3);
                                          } else if (order.status == DatumStatus.PENDING) {
                                            tileColor = Colors.green.withOpacity(0.3);
                                          } else {
                                            tileColor = Colors.white; // Default color for other statuses
                                          }

                                          return Container(
                                            height: 100,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/blueberry-pancake.svg',
                                                  width: 65,
                                                  height: 65,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Order NO:",
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
                                                          "Status:",
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
                                                    // Display items' names
                                                    // Display items' names
                                                  ],
                                                ),
                                              ],
                                            ),
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
                                          );
                                        },
                                      );
                                    }
                                  }
                                }),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Opening Orders Tab

                      Container(
                        height: G_height,
                        width: G_width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: G_height * 0.01),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await l_Vm_CommonLayout.fncPendingOrderFilter();
                                  l_Vm_CommonLayout.RxListModOrderHistoryPenidng?.refresh();
                                },
                                child: Obx(() {
                                  if (l_Vm_CommonLayout.isLoadingPendingOrders.isTrue) {
                                    // Show a loading indicator
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    if (l_Vm_CommonLayout.RxListModOrderHistoryPenidng == null ||
                                        l_Vm_CommonLayout.RxListModOrderHistoryPenidng!.isEmpty) {
                                      // Show "List is empty" message
                                      return Center(
                                        child: Text(
                                          "You don't have any new orders",
                                          style: GoogleFonts.ubuntu(
                                            textStyle: const TextStyle(
                                                fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return ListView.separated(
                                        itemCount: l_Vm_CommonLayout.RxListModOrderHistoryPenidng!.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) => SizedBox(
                                          height: G_height * 0.02,
                                        ),
                                        padding: EdgeInsets.only(left: G_width * 0.03, right: G_width * 0.03),
                                        itemBuilder: (context, index) {
                                          final order = l_Vm_CommonLayout.RxListModOrderHistoryPenidng![index];
                                          final items = order.items;
                                          final resturent = order.restaurant;
                                          final status = order.status;
                                          final user = order.user;

                                          // Define the color based on the order status
                                          Color tileColor;
                                          if (order.status == DatumStatus.CANCELLED) {
                                            tileColor = Colors.red.withOpacity(0.3);
                                          } else if (order.status == DatumStatus.PROCESSING) {
                                            tileColor = Colors.lightBlue.withOpacity(0.3);
                                          } else if (order.status == DatumStatus.PENDING) {
                                            tileColor = Colors.orangeAccent.withOpacity(0.3);
                                          } else {
                                            tileColor = Colors.white; // Default color for other statuses
                                          }

                                          return GestureDetector(
                                            onTap: () {
                                              // Handle the tap event here

                                              print(order.id);
                                              cmGlobalVariables.pBOrderId = order.id;

                                              // Add any additional actions you want to perform when tapping on the item.
                                            },
                                            child: Container(
                                              height: G_height * 0.18,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/blueberry-pancake.svg',
                                                    width: 65,
                                                    height: 65,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Order NO:",
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
                                                            "Status:",
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
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              cmGlobalVariables.pBisAccepted = true;

                                                              print("Button pressed at index: $index");
                                                              cmGlobalVariables.pBOrderId = order.id;
                                                              cmGlobalVariables.pBOrderStatusId =
                                                                  cmGlobalVariables.pBOrderId = order.id;
                                                              cmGlobalVariables.pBOrderStatus = "processing";
                                                              print(cmGlobalVariables.pBOrderId);

                                                              Get.dialog(
                                                                const Center(
                                                                  child:
                                                                      CircularProgressIndicator(), // Replace with your desired loading indicator widget
                                                                ),
                                                                barrierDismissible: false,
                                                              );

                                                              bool isCall = await l_Vm_Home.fnc_OrderAccRej();
                                                              await l_Vm_Home.fnc_UpdateOrderStatus();
                                                              await l_Vm_CommonLayout.fnc_GetAllOrders();
                                                              await l_Vm_CommonLayout.fncPendingOrderFilter();
                                                              l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                                              l_Vm_CommonLayout.isLoadingPendingOrders.refresh();
                                                              Get.back(); // Close the loading indicator dialog

                                                              if (isCall) {
                                                                print("Api called");
                                                                Get.snackbar(
                                                                  "Alert",
                                                                  "",
                                                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                                                  icon: const Icon(Icons.check_circle,
                                                                      color: Colors.deepOrange),
                                                                  duration: const Duration(seconds: 3),
                                                                  snackPosition: SnackPosition.TOP,
                                                                  margin: const EdgeInsets.all(16),
                                                                  borderRadius: 10,
                                                                  borderWidth: 1,
                                                                  borderColor: Colors.white,
                                                                  messageText: const Text(
                                                                    "Order Accepted",
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                );
                                                              } else {
                                                                Get.snackbar(
                                                                  "Alert",
                                                                  "",
                                                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                                                  icon: const Icon(Icons.error_outline,
                                                                      color: Colors.redAccent),
                                                                  duration: const Duration(seconds: 3),
                                                                  snackPosition: SnackPosition.TOP,
                                                                  margin: const EdgeInsets.all(16),
                                                                  borderRadius: 10,
                                                                  borderWidth: 1,
                                                                  borderColor: Colors.white,
                                                                  messageText: const Text(
                                                                    "Error",
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              minimumSize: Size(70, 38),
                                                              elevation: 4,
                                                              // Set the width and height as needed
                                                              foregroundColor: Colors.black,
                                                              backgroundColor: Colors.green.shade200,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Accept',
                                                              style: GoogleFonts.ubuntu(
                                                                textStyle: const TextStyle(
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 15,
                                                                  color: Colors.white,
                                                                  letterSpacing: 0.5, // Removed the period before 5
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            indent: 10,
                                                            endIndent: 10,
                                                            color: Colors.black54,
                                                            thickness: 0.1,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              cmGlobalVariables.pBisAccepted = true;

                                                              print("Button pressed at index: $index");
                                                              cmGlobalVariables.pBOrderId = order.id;
                                                              cmGlobalVariables.pBOrderStatusId =
                                                                  cmGlobalVariables.pBOrderId = order.id;
                                                              cmGlobalVariables.pBOrderStatus = "cancelled";
                                                              print(cmGlobalVariables.pBOrderId);

                                                              Get.dialog(
                                                                const Center(
                                                                  child:
                                                                      CircularProgressIndicator(), // Replace with your desired loading indicator widget
                                                                ),
                                                                barrierDismissible: false,
                                                              );

                                                              bool isCall = await l_Vm_Home.fnc_OrderAccRej();
                                                              await l_Vm_Home.fnc_UpdateOrderStatus();
                                                              await l_Vm_CommonLayout.fnc_GetAllOrders();
                                                              await l_Vm_CommonLayout.fncPendingOrderFilter();

                                                              l_Vm_CommonLayout.RxListModUserAllOrders?.refresh();
                                                              l_Vm_CommonLayout.isLoadingPendingOrders.refresh();

                                                              Get.back(); // Close the loading indicator dialog

                                                              if (isCall) {
                                                                print("Api called");
                                                                Get.snackbar(
                                                                  "Alert",
                                                                  "",
                                                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                                                  icon: const Icon(Icons.check_circle,
                                                                      color: Colors.deepOrange),
                                                                  duration: const Duration(seconds: 3),
                                                                  snackPosition: SnackPosition.TOP,
                                                                  margin: const EdgeInsets.all(16),
                                                                  borderRadius: 10,
                                                                  borderWidth: 1,
                                                                  borderColor: Colors.white,
                                                                  messageText: const Text(
                                                                    "Order Rejected",
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                );
                                                              } else {
                                                                Get.snackbar(
                                                                  "Alert",
                                                                  "",
                                                                  backgroundColor: Colors.deepOrange.withOpacity(0.2),
                                                                  icon: const Icon(Icons.error_outline,
                                                                      color: Colors.redAccent),
                                                                  duration: const Duration(seconds: 3),
                                                                  snackPosition: SnackPosition.TOP,
                                                                  margin: const EdgeInsets.all(16),
                                                                  borderRadius: 10,
                                                                  borderWidth: 1,
                                                                  borderColor: Colors.white,
                                                                  messageText: const Text(
                                                                    "Error",
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              minimumSize: Size(70, 38),
                                                              elevation: 4,
                                                              // Set the width and height as needed
                                                              foregroundColor: Colors.black,
                                                              backgroundColor: Colors.redAccent.shade100,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Reject',
                                                              style: GoogleFonts.ubuntu(
                                                                textStyle: const TextStyle(
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 15,
                                                                  color: Colors.white,
                                                                  letterSpacing: 0.5, // Removed the period before 5
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // Display items' names
                                                      // Display items' names
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
