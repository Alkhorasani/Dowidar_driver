import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_util.dart';



class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double? hintSize;
  final TextAlign textAlign;
  final Color? color;
  final bool? enabled;
  final double height;
  final int? lines;
  final TextInputType? keyboardType;
  final Color? filledColor;
  final  IconData? iconData;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool obscureText;
  final int? length;
  final String? Function(String?)? validator;
  final IconData? icon;



  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.hintSize,
    this.textAlign = TextAlign.start,
    this.color,
    this.enabled,
    required this.height,
    this.lines,
    this.keyboardType,
    this.filledColor,
    this.iconData,
    required this.onChange,
    this.focusNode,
    this.autofocus = false,
    this.obscureText = false,
    this.validator, this.length, this.icon, this.onSaved, this.onFieldSubmitted,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorUtil.textFiled,
      ),
      margin: EdgeInsets.zero,
      child: Center(
        child: TextFormField(
          autofocus: autofocus,
          keyboardType: keyboardType,
          obscureText: obscureText,
          focusNode: focusNode,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          textAlign: textAlign,
          enabled: enabled,
          maxLines: 1,
          maxLength: length,
          autocorrect: true,
          controller: controller,
          onChanged: onChange,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyle(fontSize: 16.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19.r),
              borderSide: BorderSide.none,
            ),
            labelText: hintText,
            labelStyle: TextStyle(
              color: color,
              fontSize: hintSize,
            ),
            prefixIcon: icon != null ? Icon(icon, color: ColorUtil.dishListText): null,
            suffixIcon: iconData != null ? Icon(
              iconData,
              size: 20.sp,
              color: ColorUtil.incDecColor,
            ) : null,
          ),
        ),
      ),
    );
  }
}