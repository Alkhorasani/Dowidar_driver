import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? styleElement;
  final TextAlign? textAlign;
  final int maxLines;
  final TextOverflow overflow;

  const CustomText({
    Key? key,
    required this.text,
    this.styleElement, this.textAlign, this.maxLines = 1, this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: styleElement,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
