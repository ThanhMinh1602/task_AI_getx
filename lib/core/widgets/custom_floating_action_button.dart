import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      
      onPressed: onPressed,
      backgroundColor: AppColor.k613BE7,
      foregroundColor: AppColor.kFFFFFF,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Icon(icon),
    );
  }
}
