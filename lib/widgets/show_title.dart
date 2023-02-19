import 'package:flutter/material.dart';

import '../utils/my_constant.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const ShowTitle({super.key, required this.title, this.textStyle, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle ?? MyConstant().h3Style(),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
