import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ClassModules/AppImages/cmGlobal_AppImages.dart';
import '../../../ClassModules/cm_StringConstants/cm_StringConstantsVwLogin.dart';
import '../../../Routing/AppRoutes.dart';
import '../../ViewModel/Vm_Login/Vm_Login.dart';

class Vw_Login extends StatefulWidget {
  const Vw_Login({super.key});

  @override
  State<Vw_Login> createState() => _Vw_LoginState();
}

class _Vw_LoginState extends State<Vw_Login> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Vm_Login l_Vmlogin = Get.put(Vm_Login());

  Widget build(BuildContext context) {
    Widget togglepassword() {
      return Obx(() {
        return IconButton(
          onPressed: () {
            l_Vmlogin.boolSecurePassword_wid.value = !l_Vmlogin.boolSecurePassword_wid.value;
          },
          icon:
              l_Vmlogin.boolSecurePassword_wid.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          color: l_Vmlogin.boolSecurePassword_wid.value
              ? Colors.deepOrangeAccent
              : Colors.grey, // set the color based on the toggle state
        );
      });
    }

    Widget _WidgetportraitMode(double G_height, G_width) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                height: G_height,
                width: G_width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(cmGlobal_Appimages.loginscreen_bgImage), fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: G_height * 0.10,
                      ),
                      child: Center(
                          child: Container(
                            height: 200,
                              decoration: BoxDecoration(
                                color: Colors.black54, // Set the background color to white

                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(cmGlobal_Appimages.splashScreen))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: G_height * 0.10,
                        left: G_width * 0.06,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.6), // Set the background color to white

                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "${'${cm_StringConstantsVwLogin.strEnterCred}'.tr}",                              style: GoogleFonts.ubuntu(
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
                    Padding(
                        padding: EdgeInsets.only(top: G_height * 0.01, left: G_width * 0.04, right: G_width * 0.04),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: l_Vmlogin.phoneController,
                          style: TextStyle(color: Colors.black),
                          // Text color for user input
                          decoration: InputDecoration(
                            hintText: "${'${cm_StringConstantsVwLogin.strPhoneNumber}'.tr}",
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 13.5, left: 10, right: 10), // Adjust the padding as needed
                              child: Text(
                                "+966 | ",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                          autofillHints: [AutofillHints.telephoneNumber],
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your phonenumber';
                          //   }
                          //   return null;
                          // },
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: G_height * 0.01, left: G_width * 0.04, right: G_width * 0.04),
                      child: Obx(() {
                        return TextFormField(
                          controller: l_Vmlogin.passswordController,
                          obscureText: !l_Vmlogin.boolSecurePassword_wid.value,
                          decoration: InputDecoration(
                            hintText: "${'${cm_StringConstantsVwLogin.strPassword}'.tr}",
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: togglepassword(),
                          ),
                          autofillHints: [AutofillHints.password],
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your password';
                          //   }
                          //   return null;
                          // },
                        );
                      }),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: G_height * 0.01),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Get.dialog(
                                  const Center(
                                    child:
                                        CircularProgressIndicator(), // Replace with your desired loading indicator widget
                                  ),
                                  barrierDismissible: false,
                                );
                                bool isLoggedin = await l_Vmlogin.fncBtnOntap_Login();
                                Get.back(); // Close the loading indicator dialog
                                if (isLoggedin) {
                                  Get.snackbar(
                                    "Login Successfully",
                                    "",
                                    backgroundColor: Colors.grey[50],
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    duration: const Duration(seconds: 2),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(16),
                                    borderRadius: 10,
                                    borderWidth: 1,
                                    borderColor: Colors.white,
                                    messageText: const Text(
                                      "Welcome Back",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                  Get.toNamed(AppRoutes.vwCommonLayout);
                                } else {
                                  Get.snackbar(
                                    "Login Failed",
                                    "",
                                    backgroundColor: Colors.grey[50],
                                    icon: const Icon(Icons.error_outline, color: Colors.redAccent),
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(16),
                                    borderRadius: 10,
                                    borderWidth: 1,
                                    borderColor: Colors.white,
                                    messageText: const Text(
                                      "Check your username or password",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }
                              } else {
                                l_Vmlogin.fieldsValidate = true;
                              }
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
                              "${'${cm_StringConstantsVwLogin.strLogin}'.tr}",
                              style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: Colors.black54,
                                  letterSpacing: 0.5, // Removed the period before 5
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
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
