import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/ViewModel/Vm_OrderDetails/Vm_OrderDeatils.dart';
import 'package:dowidardriver/Routing/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ViewModel/Vm_Login/Vm_Login.dart';

class Vw_OrderDetails extends StatefulWidget {
  const Vw_OrderDetails({Key? key});

  @override
  State<Vw_OrderDetails> createState() => _Vw_OrderDetailsState();
}

class _Vw_OrderDetailsState extends State<Vw_OrderDetails> {
  @override
  final Vm_OrderDetails l_VmOrderDetails = Get.put(Vm_OrderDetails());

  @override
  void initState() {
    l_VmOrderDetails.fnc_OrderDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double G_height, G_width) {
      return SafeArea(
        child: Scaffold(
          floatingActionButton:  FloatingActionButton(
            onPressed: () async {
              final l_SharedPreferences = await SharedPreferences.getInstance();
              final id = l_SharedPreferences.getString('l_driverID') ?? '';
              cmGlobalVariables.pbDriberID = id;


              print(cmGlobalVariables.pbDriberID );
              print(cmGlobalVariables.pBOntapOrderId);
              print(cmGlobalVariables.pbUserID);

              Get.toNamed(AppRoutes.vwChat);


              },
            child: Icon(Icons.message),
            mini: true, // Set to true to make it a small FAB
            backgroundColor: Colors.deepOrange, // Customize the background color
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Order Details",
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
              children: [
                SizedBox(
                  height: G_height * 0.25,
                ),
                Center(
                  child: Obx(() {
                    if (l_VmOrderDetails.isLoading.isTrue) {
                      return Center(
                        child: CircularProgressIndicator(), // Show loading indicator
                      );
                    } else if (l_VmOrderDetails.orderDetails != null) {

                      cmGlobalVariables.pbUserID = l_VmOrderDetails.orderDetails?.data?.order?.userId ;

                      // Data is available, show the card
                      return Container(
                        width: G_height * 0.450,
                        child: Card(
                          color: Colors.deepOrange.withOpacity(0.5),
                          elevation: 15,
                          margin: EdgeInsets.all(16),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Restaurant Info',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // Add data from orderDetails here
                                Text(
                                    'Restaurant Name: ${l_VmOrderDetails.orderDetails?.data?.order?.restaurant?.name}'),
                                SizedBox(height: 8),
                                Text('Driver Name: ${l_VmOrderDetails.orderDetails?.data?.order?.driver?.fullName}'),
                                SizedBox(height: 16),
                                Text(
                                  'Order Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Order No: ${l_VmOrderDetails.orderDetails?.data?.order?.orderNo}'),

                                // Add more data fields as needed
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Handle the case when data is not available
                      return Text('Data not available');
                    }
                  }),
                ),
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
