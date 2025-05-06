import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc_base_structure/core/app_extension.dart';
import 'package:flutter_bloc_base_structure/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = ColorName.buttonBackground,
    this.textColor = ColorName.textWhiteColor,
    this.borderRadius = 6.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // makes button full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ).paddingSymmetric(vertical: 0.015.sh),
      ),
    );
  }
}
