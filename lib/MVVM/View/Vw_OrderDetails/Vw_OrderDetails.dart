import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_OrderDetails/Vm_OrderDeatils.dart';
import 'package:dowidardriver/Routing/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ClassModules/AppImages/cmGlobal_AppImages.dart';
import '../../../ClassModules/cm_StringConstants/cm_StringConstantsVwHome.dart';
import '../../../ClassModules/cm_StringConstants/cm_StringConstantsVwOrderDetails.dart';
import '../../../Enum/EnumStatus.dart';
import '../../ViewModel/Vm_Login/Vm_Login.dart';

class Vw_OrderDetails extends StatefulWidget {
  const Vw_OrderDetails({Key? key});

  @override
  State<Vw_OrderDetails> createState() => _Vw_OrderDetailsState();
}

class _Vw_OrderDetailsState extends State<Vw_OrderDetails> {
  @override
  final Vm_OrderDetails l_VmOrderDetails = Get.put(Vm_OrderDetails());
  final Vm_Home lVm_Home = Get.find<Vm_Home>();

  DateTime? createdAt;
  String? date;
  String? time;

  @override
  void initState() {
    l_VmOrderDetails.fnc_OrderDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double G_height, G_width) {
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Obx(() {


            if(l_VmOrderDetails.orderDetails.value?.data?.statuses?.delivered != null
                || l_VmOrderDetails.orderDetails.value?.data?.statuses?.delivered == "delivered"   ){

              return
                Padding(
                  padding:  EdgeInsets.only(left: G_width*0.23),
                  child: Text(
                    "${'${cm_StringConstantsVwOrderDetails.strYourOrderDeliverd}'.tr}",
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                          fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
            }
            else{
              return BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        cmGlobalVariables.pBOrderStatusId = cmGlobalVariables.pBOrderId =
                            l_VmOrderDetails.orderDetails.value?.data?.order?.id;
                        cmGlobalVariables.pBOrderStatus = Status.OrderDeliverd;
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          barrierDismissible: false,
                        );
                        bool isCall = await lVm_Home.fnc_UpdateOrderStatus();
                        await l_VmOrderDetails.fnc_OrderDetails();
                        l_VmOrderDetails.orderDetails.refresh();


                        Get.back();
                        if (isCall) {
                          print("Api called");
                          Get.snackbar(
                            "${'${cm_StringConstantsVwHome.strAlert}'.tr}",
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
                              "Order Delivered",
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "${'${cm_StringConstantsVwHome.strAlert}'.tr}",
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
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(G_width * 0.80, G_height * 0.10),
                        elevation: 6,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "${'${cm_StringConstantsVwOrderDetails.strDelivered}'.tr}",
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

            }
          }),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final l_SharedPreferences = await SharedPreferences.getInstance();
              final id = l_SharedPreferences.getString('l_driverID') ?? '';
              cmGlobalVariables.pbDriberID = id;

              print(cmGlobalVariables.pbDriberID);
              print(cmGlobalVariables.pBOntapOrderId);
              print(cmGlobalVariables.pbUserID);

              Get.toNamed(AppRoutes.vwChat);
            },
            child: Icon(Icons.message),
            mini: true, // Set to true to make it a small FAB
            backgroundColor: Colors.deepOrange, // Customize the background color
          ),
          appBar: AppBar(
            title: Text(
              "${'${cm_StringConstantsVwOrderDetails.strOrderDetails}'.tr}",
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: .5)),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  if (l_VmOrderDetails.isLoading.isTrue) {
                    return Center(
                      child: CircularProgressIndicator(), // Show loading indicator
                    );
                  } else if (l_VmOrderDetails.orderDetails != null) {
                    String? rawCreatedAt = l_VmOrderDetails.orderDetails.value?.data?.order?.createdAt;

                    String? Paymenttype;

                    if (rawCreatedAt != null) {
                      createdAt = DateTime.parse(rawCreatedAt);
                      date = DateFormat('dd/MM/yy').format(createdAt!);
                      time = DateFormat('hh:mm a').format(createdAt!);
                    }

                    Paymenttype = l_VmOrderDetails.orderDetails.value?.data?.order
                        ?.paymentType(l_VmOrderDetails.orderDetails.value?.data?.order?.paymentHistories);

                    cmGlobalVariables.pbUserID = l_VmOrderDetails.orderDetails.value?.data?.order?.userId;

                    // Data is available, show the card
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: G_width * 0.03),
                          child: Container(
                            width: G_height * 0.450,
                            child: Card(
                              color: Colors.white,
                              elevation: 15,
                              margin: EdgeInsets.all(16),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${'${cm_StringConstantsVwOrderDetails.strRestaurantInfo}'.tr}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: G_height * 0.01),
                                    // Add data from orderDetails here
                                    Text(
                                        "${'${cm_StringConstantsVwOrderDetails.strRestaurantInfo}'
                                            .tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.restaurant?.name
                                            .toString()}"),
                                    SizedBox(height: G_height * 0.01),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                double? lat = l_VmOrderDetails
                                                    .orderDetails.value?.data?.order?.restaurant?.location?.latitude;
                                                double? lng = l_VmOrderDetails
                                                    .orderDetails.value?.data?.order?.restaurant?.location?.longitude;
                                                if (lat != null && lng != null) {
                                                  launch("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
                                                }
                                              },
                                              icon: Icon(Icons.pin_drop, size: 35, color: Colors.deepOrange),
                                            ),
                                            Text(
                                              "${'${cm_StringConstantsVwOrderDetails.strLocation}'.tr}",
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8,
                                                  color: Colors.black38,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: G_width * 0.03,
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                String? phoneNumber = l_VmOrderDetails
                                                    .orderDetails.value?.data?.order?.restaurant?.phoneNumber;
                                                if (phoneNumber != null) {
                                                  launch("tel:$phoneNumber");
                                                }
                                                // Handle button press for the map icon
                                              },
                                              icon: Icon(Icons.phone, size: 32, color: Colors.deepOrange),
                                            ),
                                            Text(
                                              "${'${cm_StringConstantsVwOrderDetails.strPhone}'.tr}",
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8,
                                                  color: Colors.black38,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Add more data fields as needed
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 1.2,
                          height: G_height * 0.001,
                          indent: 60,
                          endIndent: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: G_width * 0.03),
                          child: Container(
                            width: G_height * 0.450,
                            child: Card(
                              color: Colors.white,
                              elevation: 15,
                              margin: EdgeInsets.all(16),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${'${cm_StringConstantsVwOrderDetails.strClientInfo}'.tr}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: G_height * 0.01),
                                    // Add data from orderDetails here
                                    Text(
                                        "${'${cm_StringConstantsVwOrderDetails.strClientName}'.tr}: ${l_VmOrderDetails
                                            .orderDetails.value?.data?.order?.user?.firstname}"),
                                    SizedBox(height: G_height * 0.01),
                                    Text(
                                        "${'${cm_StringConstantsVwOrderDetails.strClientEmail}'.tr}: ${l_VmOrderDetails
                                            .orderDetails.value?.data?.order?.user?.email}"),

                                    SizedBox(height: G_height * 0.01),
                                    Text(
                                        "${'${cm_StringConstantsVwOrderDetails.strClientAddress}'
                                            .tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.address
                                            ?.addressLine2}"),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                double? lat =
                                                    l_VmOrderDetails.orderDetails.value?.data?.order?.user?.latitude;
                                                double? lng =
                                                    l_VmOrderDetails.orderDetails.value?.data?.order?.user?.longitude;
                                                if (lat != null && lng != null) {
                                                  launch("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
                                                }
                                              },
                                              icon: Icon(Icons.pin_drop, size: 35, color: Colors.deepOrange),
                                            ),
                                            Text(
                                              "${'${cm_StringConstantsVwOrderDetails.strLocation}'.tr}",
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8,
                                                  color: Colors.black38,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: G_width * 0.03,
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                String? phoneNumber =
                                                    l_VmOrderDetails.orderDetails.value?.data?.order?.user?.phone;
                                                if (phoneNumber != null) {
                                                  launch("tel:$phoneNumber");
                                                }
                                                // Handle button press for the map icon
                                              },
                                              icon: Icon(Icons.phone, size: 32, color: Colors.deepOrange),
                                            ),
                                            Text(
                                              "${'${cm_StringConstantsVwOrderDetails.strPhone}'.tr}",
                                              style: GoogleFonts.ubuntu(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8,
                                                  color: Colors.black38,
                                                  letterSpacing: 0.6,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Add more data fields as needed
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 1.2,
                          height: G_height * 0.001,
                          indent: 60,
                          endIndent: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: G_width * 0.03),
                          child: Container(
                            width: G_height * 0.450,
                            child: Card(
                              color: Colors.white,
                              elevation: 15,
                              margin: EdgeInsets.all(16),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${'${cm_StringConstantsVwOrderDetails.strOrderInfo}'.tr}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: G_height * 0.01),
                                    // Add data from orderDetails here
                                    Text(
                                        '${'${cm_StringConstantsVwOrderDetails.strOrderNumber}'.tr}: ${l_VmOrderDetails
                                            .orderDetails.value?.data?.order?.orderNo}'),
                                    SizedBox(height: G_height * 0.01),
                                    Text(
                                        '${'${cm_StringConstantsVwOrderDetails.strOrderStatus}'.tr}: ${l_VmOrderDetails
                                            .orderDetails.value?.data?.order?.status}'),
                                    SizedBox(height: G_height * 0.01),
                                    Text(
                                        '${'${cm_StringConstantsVwOrderDetails.strOrderCreatedAt}'.tr}: $time - $date'),
                                    SizedBox(height: G_height * 0.01),

                                    Text('${'${cm_StringConstantsVwOrderDetails.strPaymentType}'.tr}: $Paymenttype'),
                                    SizedBox(height: G_height * 0.01),

                                    // Add more data fields as needed
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: G_width * 0.13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${'${cm_StringConstantsVwOrderDetails.strItems}'.tr}",
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: .5)),
                              ),
                              Visibility(
                                visible: l_VmOrderDetails.orderDetails.value?.data?.order?.statuses?.delivered ==
                                    "delivered",
                                child: ElevatedButton(
                                  onPressed: () async {
                                    cmGlobalVariables.pBOrderStatusId = cmGlobalVariables.pBOrderId =
                                        l_VmOrderDetails.orderDetails.value?.data?.order?.id;
                                    cmGlobalVariables.pBOrderStatus = Status.OrderDeliverd;
                                    Get.dialog(
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      barrierDismissible: false,
                                    );
                                    bool isCall = await lVm_Home.fnc_UpdateOrderStatus();
                                    Get.back();
                                    if (isCall) {
                                      print("Api called");
                                      Get.snackbar(
                                        "${'${cm_StringConstantsVwHome.strAlert}'.tr}",
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
                                          "Order Delivered",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    } else {
                                      Get.snackbar(
                                        "${'${cm_StringConstantsVwHome.strAlert}'.tr}",
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
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(40, 30),
                                    elevation: 6,
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                    "${'${cm_StringConstantsVwOrderDetails.strDelivered}'.tr}",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: G_height * 0.01),
                        ListView.separated(
                          itemCount: l_VmOrderDetails.orderDetails.value!.data!.order!.items!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: G_height * 0.02,
                              ),
                          padding: EdgeInsets.only(left: G_width * 0.07, right: G_width * 0.07),
                          itemBuilder: (context, index) {
                            final item = l_VmOrderDetails.orderDetails.value!.data!.order!.items![index];

                            // Define the color based on the order status
                            Color tileColor = Colors.white;

                            return GestureDetector(
                              onTap: () async {},
                              child: Container(
                                height: G_height * 0.10,
                                width: G_width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${'${cm_StringConstantsVwOrderDetails.strItemName}'.tr}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.name.toString(),
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
                                              "${'${cm_StringConstantsVwOrderDetails.strItemName}'.tr}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.name.toString(),
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
                                              "${'${cm_StringConstantsVwOrderDetails.strResturent}'.tr}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.name.toString(),
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
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    // Handle the case when data is not available
                    return Text('Data not available');
                  }
                }),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = MediaQuery
                  .of(context)
                  .size
                  .height;
              double width = MediaQuery
                  .of(context)
                  .size
                  .width;

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
