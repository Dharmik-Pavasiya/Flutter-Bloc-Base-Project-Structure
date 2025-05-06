import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc_base_structure/core/app_extension.dart';
import 'package:flutter_bloc_base_structure/gen/colors.gen.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    this.initialValue,
    this.onChanged,
    this.validator,
    this.maxLine,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.hint,
    super.key,
  });

  final String? initialValue;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final AutovalidateMode autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      autovalidateMode: autoValidateMode,
      cursorColor: Colors.grey,
      initialValue: initialValue,
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon?.paddingAll(0.03.sw),
        suffixIcon: suffixIcon?.paddingAll(0.03.sw),
        filled: true,
        fillColor: ColorName.textFieldBackgroundColor,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
