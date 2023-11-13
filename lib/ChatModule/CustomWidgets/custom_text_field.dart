import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_util.dart';

class CustomTextField1 extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function? onPress;
  final double? width;
  final Widget? suffixIcon;
  final String? receiverId;
  final bool? readOnly;
  final Function(String) onChange;

  const CustomTextField1({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onPress,
    this.width,
    this.suffixIcon, this.receiverId, required this.onChange, this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomTextField1State createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
      height: 55.h,
      // width: widget.width!,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
      child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          autocorrect: true,
          controller: widget.controller,
          readOnly: widget.readOnly ?? false,
          style:  TextStyle(color: ColorUtil.textColor),
          // maxLength: 250,
          expands: false,
          minLines: null,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.sp),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: widget.suffixIcon,
          ),
          onChanged: widget.onChange
      ),
    );
  }

}
