import 'package:cached_network_image/cached_network_image.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_OrderDetails/Vm_OrderDeatils.dart';
import 'package:dowidardriver/Routing/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../../CustomWidgets/ArabicTextField.dart';
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
            if (l_VmOrderDetails.orderDetails.value?.data?.order?.status! == Status.OrderDeliverd) {
              print(l_VmOrderDetails.orderDetails.value?.data?.order?.status!);
              return Padding(
                padding: EdgeInsets.only(left: G_width * 0.23),
                child: Text(
                  "${'${cm_StringConstantsVwOrderDetails.strYourOrderDeliverd}'.tr}",
                  style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                ),
              );
            } else {

              if (l_VmOrderDetails.orderDetails.value?.data?.order?.status! == Status.OrderEnroute){
                return BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          cmGlobalVariables.pBOrderStatusId =
                              cmGlobalVariables.pBOrderId = l_VmOrderDetails.orderDetails.value?.data?.order?.id;
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
                          } else {}
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
              else{
                return Padding(
                  padding: EdgeInsets.only(left: G_width * 0.23),
                  child:Text(
                    "${'${cm_StringConstantsVwOrderDetails.strOrderEnroute}'.tr}",
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(fontSize: 25, color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ),
                );

              }

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
          body: Container(
            height: G_height,
            width: G_width,
            color: Colors.white,
            child:  Obx(() {
              if (l_VmOrderDetails.isLoading.isTrue) {
                return Center(
                  child: CircularProgressIndicator(), // Show loading indicator
                );
              } else if (l_VmOrderDetails.orderDetails != null) {
                l_VmOrderDetails.fnc_processOrderDetails();

                // Data is available, show the card
                return SingleChildScrollView(
                  child: Column(
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
                                      "${'${cm_StringConstantsVwOrderDetails.strRestaurantName}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.restaurant?.name.toString()}"),
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
                                      "${'${cm_StringConstantsVwOrderDetails.strClientName}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.user?.firstname}"),
                                  SizedBox(height: G_height * 0.01),
                                  Text(
                                      "${'${cm_StringConstantsVwOrderDetails.strClientEmail}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.user?.email}"),

                                  SizedBox(height: G_height * 0.01),
                                  Text(
                                      "${'${cm_StringConstantsVwOrderDetails.strClientAddress}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.address?.addressLine2}"),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                        crossAxisAlignment: CrossAxisAlignment.center,

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
                                            icon: Icon(Icons.phone, size: 35, color: Colors.deepOrange),
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
                                      '${'${cm_StringConstantsVwOrderDetails.strOrderNumber}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.orderNo}'),
                                  SizedBox(height: G_height * 0.01),
                                  Text(
                                      '${'${cm_StringConstantsVwOrderDetails.strOrderStatus}'.tr}: ${l_VmOrderDetails.orderDetails.value?.data?.order?.status}'),
                                  SizedBox(height: G_height * 0.01),
                                  Text(
                                      '${'${cm_StringConstantsVwOrderDetails.strOrderCreatedAt}'.tr}: ${l_VmOrderDetails.date} - ${l_VmOrderDetails.time}'),
                                  SizedBox(height: G_height * 0.01),

                                  Text(
                                      '${'${cm_StringConstantsVwOrderDetails.strPaymentType}'.tr}: ${l_VmOrderDetails.Paymenttype}'),
                                  SizedBox(height: G_height * 0.01),

                                  // Add more data fields as needed
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: G_width * 0.1),
                        child: Row(
                          children: [
                            Text(
                              "${'${cm_StringConstantsVwOrderDetails.strItems}'.tr}",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: .5)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: G_height * 0.01),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: l_VmOrderDetails.orderDetails.value!.data!.order!.items!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: G_width * 0.07, right: G_width * 0.07),
                        itemBuilder: (context, index) {
                          final item = l_VmOrderDetails.orderDetails.value!.data!.order!.items![index];

                          // Define the color based on the order status
                          Color tileColor = Colors.deepOrange.withOpacity(0.3);

                          return GestureDetector(
                            onTap: () async {},
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: G_height * 0.190, // Adjust the height according to your design
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    // Left side - Image
                                    Container(
                                      width: G_width * 0.25,
                                      height: G_height * 0.13,
                                      child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Card(
                                            elevation: 8, // Set the elevation as per your preference
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0), // Adjust the border radius as needed
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              // Same as the border radius above
                                              child: CachedNetworkImage(
                                                imageUrl: item.imageUrl.toString(),
                                                placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                    ),
                                    SizedBox(width: G_width * 0.012),
                                    // Right side - Text
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(() {
                                            if (lVm_Home.isArabic.value == true) {
                                              print("  item name in arabic ${item.arName.toString()}");
                                              print("  item name in engdlih ${item.name.toString()}");

                                              return CustomRestaurantNameText(restaurantName: item.arName.toString());
                                            } else {
                                              return buildRow("", item.name.toString());
                                            }
                                          }),
                                          buildRow("${'${cm_StringConstantsVwOrderDetails.strItemQty}:'.tr}",
                                              item.pivot!.quantity.toString()),
                                          Obx(() {
                                            if (l_VmOrderDetails.isMethodCash.value == false)
                                              return buildRow(
                                                  "${'${cm_StringConstantsVwOrderDetails.strItemPrice}:'.tr}",
                                                  item.price.toString());
                                            else {
                                              return Text("  ");
                                            }
                                          }),
                                          Obx(() {
                                            if (l_VmOrderDetails.isMethodCash.value == false)
                                              return buildRow("${'${cm_StringConstantsVwOrderDetails.strTotal}:'.tr}",
                                                  l_VmOrderDetails.TotalCash.toString());
                                            else {
                                              return Text("  ");
                                            }
                                          })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                // Handle the case when data is not available
                return Text('Data not available');
              }
            }),
          )
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

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black45,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
