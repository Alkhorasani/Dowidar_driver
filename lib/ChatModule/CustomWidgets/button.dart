import 'package:flutter/material.dart';

import 'color_util.dart';
import 'text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.btnColor,
      required this.radius,
      required this.text,
      required this.onPressed,
      this.styleElement,
      this.child,
      this.mainAxisAlignment,
      this.isConnected = false,
      this.inProcess = false,
      this.textAlign})
      : super(key: key);

  final double height;
  final double width;
  final Color btnColor;
  final double radius;
  final String text;
  final Function onPressed;
  final TextStyle? styleElement;
  final Widget? child;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isConnected;
  final bool inProcess;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isConnected ? ColorUtil.noConnectionColor : btnColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            if (child != null) Center(child: child!),
            Center(
              child: inProcess ? CircularProgressIndicator(
                color: Colors.white,
              ) : CustomText(
                textAlign: textAlign,
                text: isConnected ? 'Cancel' : text,
                styleElement: styleElement,
              ),
            )
          ],
        ),
      ),
    );
  }
}
