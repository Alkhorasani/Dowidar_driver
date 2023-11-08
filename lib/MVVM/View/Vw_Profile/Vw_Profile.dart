import 'package:dowidardriver/ClassModules/AppImages/cmGlobal_AppImages.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../Routing/AppRoutes.dart';

class VwUserProfile extends StatefulWidget {
  const VwUserProfile({super.key});

  @override
  State<VwUserProfile> createState() => _VwUserProfileState();
}

class _VwUserProfileState extends State<VwUserProfile> {
  @override
  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
      return WillPopScope(
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
              "My Profile",
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      //fontWeight: FontWeight.w600,
                      letterSpacing: .5)),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: PrHeight,
            width: PrWidth,
            //color: Colors.black,
            padding: const EdgeInsets.all(16.0),
            child: Stack(

              children: <Widget>[
                Positioned(
                  top: PrHeight * 0.06,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: PrHeight * 0.20,
                    child: Container(

                      width: PrWidth * 0.500,
                      height: PrHeight * 0.30,
                      padding: EdgeInsets.all(PrHeight * 0.010),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(cmGlobal_Appimages.profilescreen_bgImage),
                          fit: BoxFit.none,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: null,
                    ),
                  ),
                ),
                Positioned(
                    top: -95,
                    left: PrWidth * 0.36,
                    height: PrHeight * 0.73,
                    child: Container(
                      height: PrHeight * 0.120,
                      width: PrWidth * 0.230,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                      ),
                      child: Image.asset(cmGlobal_Appimages.profilescreen_prfImage),
                    )),
                Positioned(
                  top: PrHeight * 0.35,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${cmGlobalVariables.Pb_ModDriverLocalData?.fullname}".toUpperCase(),
                        style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                //fontWeight: FontWeight.w600,
                                letterSpacing: .5)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: PrHeight * 0.40,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    child: Container(
                      width: PrWidth * 0.500,
                      height: PrHeight * 0.27,
                      padding: EdgeInsets.all(PrHeight * 0.010),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: PrHeight * 0.03),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "Email",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black45,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "${cmGlobalVariables.Pb_ModDriverLocalData?.email}",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: PrHeight * 0.02),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "Status",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black45,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "${cmGlobalVariables.Pb_ModDriverLocalData?.status}",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: PrHeight * 0.02),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "Phone Number",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black45,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: PrWidth * 0.03), // Add a minor space from the left side
                              Text(
                                "${cmGlobalVariables.Pb_ModDriverLocalData?.phone}",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: PrHeight * 0.54,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 0.3,
                          indent: PrWidth * 0.04,
                          endIndent: PrWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: PrHeight * 0.61,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 0.3,
                          indent: PrWidth * 0.04,
                          endIndent: PrWidth * 0.04,
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
