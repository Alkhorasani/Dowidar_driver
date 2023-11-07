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

import '../../../CustomWidgets/CustomNavigation_Bar.dart';
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
    super.initState();
    l_Vm_Home.getPopulerdiets();
    final Vm_Login l_Vm_Login = Get.put(Vm_Login());
    l_Vm_Login.fncGetUserData();

    print('Latitude: ${cmGlobalVariables.pBUserLatitude}, Longitude:  ${cmGlobalVariables.pBUserLatitude}');
  }

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double G_height, double G_width) {
      return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          //  bottomNavigationBar: CustomBottomNavigationBar(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: G_height * 0.00),
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
                            onChanged: (value) {
                              l_Vm_Home.isActiveSwitch.value = value;
                            },
                            value: l_Vm_Home.isActiveSwitch.value,
                            activeColor: Colors.deepOrange.withOpacity(0.6),
                            blurRadius: 4,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: false,
            // You may want to set this to false if you don't want the title centered
            elevation: 0.0,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
              // TabBar for two tabs
              tabs: [
                Tab(text: "Current Orders"),
                Tab(text: "New Orders"),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            // TabBarView for content corresponding to the tabs
            children: [
              // New Orders Tab
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 20,top: 10),
                    //   child: Text(
                    //     'Popular',
                    //     style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),

                    Obx(() {
                      return ListView.separated(
                        itemCount: l_Vm_CommonLayout.RxListModUserAllOrders!.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 25,
                        ),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/salmon-nigiri.svg',
                                  width: 65,
                                  height: 65,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l_Vm_CommonLayout.RxListModUserAllOrders![index].orderNo.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: SvgPicture.asset(
                                //     'assets/icons/button.svg',
                                //     width: 30,
                                //     height: 30,
                                //   ),
                                // )
                              ],
                            ),
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                              BoxShadow(
                                  color: const Color(0xff1D1617).withOpacity(0.07),
                                  offset: const Offset(0, 10),
                                  blurRadius: 40,
                                  spreadRadius: 0)
                            ]),
                          );
                        },
                      );
                    })
                  ],
                ),
              ),

              // Opening Orders Tab
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Reuguler',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      itemCount: l_Vm_Home.l_PopularDiets.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 25,
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                l_Vm_Home.l_PopularDiets[index].iconPath,
                                width: 65,
                                height: 65,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l_Vm_Home.l_PopularDiets[index].name,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    l_Vm_Home.l_PopularDiets[index].level +
                                        ' | ' +
                                        l_Vm_Home.l_PopularDiets[index].duration +
                                        ' | ' +
                                        l_Vm_Home.l_PopularDiets[index].calorie,
                                    style: const TextStyle(
                                        color: Color(0xff7B6F72), fontSize: 13, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: SvgPicture.asset(
                              //     'assets/icons/button.svg',
                              //     width: 30,
                              //     height: 30,
                              //   ),
                              // )
                            ],
                          ),
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                            BoxShadow(
                                color: const Color(0xff1D1617).withOpacity(0.07),
                                offset: const Offset(0, 10),
                                blurRadius: 40,
                                spreadRadius: 0)
                          ]),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
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
