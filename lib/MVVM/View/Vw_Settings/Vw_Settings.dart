import 'package:dowidardriver/MVVM/ViewModel/Vm_Settings/Vm_Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Routing/AppRoutes.dart';

class Vw_Settings extends StatefulWidget {
  const Vw_Settings({super.key});

  @override
  State<Vw_Settings> createState() => _Vw_SettingsState();
}

class _Vw_SettingsState extends State<Vw_Settings> {
  @override
  final Vm_Settings l_Vm_Settings = Get.put(Vm_Settings());

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
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
                  "Settings",
                  style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          //fontWeight: FontWeight.w600,
                          letterSpacing: .5)),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        l_Vm_Settings.fnc_ClearData();
                        Get.offAllNamed(AppRoutes.vwLogin);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        // Set the width and height as needed
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.deepOrange.withOpacity(0.9),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black54,
                            letterSpacing: 0.5, // Removed the period before 5
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Add some spacing between the buttons
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        // Set the width and height as needed
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.deepOrange.withOpacity(0.9),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        'Change Language',
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black54,
                            letterSpacing: 0.5, // Removed the period before 5
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.vwChat);

                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        // Set the width and height as needed
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.deepOrange.withOpacity(0.9),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        'Chat Support',
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black54,
                            letterSpacing: 0.5, // Removed the period before 5
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
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
