import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, this.size, this.color});
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'LOGO',
      child: Icon(Icons.task_alt,
          size: size ?? 80, color: color ?? AppColor.k613BE7),
    );
  }
}
