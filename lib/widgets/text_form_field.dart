import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Custom text form field for input fields e.g. Forms
class VTextFormField extends StatelessWidget {
  final String? title;
  final TextInputType? inputType;
  final VoidCallback? onTapSuffixIcon;
  final bool isObscureText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Function? validator;

  VTextFormField(
      {this.title,
      this.inputType,
      this.onTapSuffixIcon,
      this.isObscureText = false,
      this.suffixIcon,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6), color: Color(0x151F54C3), blurRadius: 20)
          ]),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isObscureText,
        controller: controller,
        keyboardType: inputType,
        validator: (val) => validator!(val),
        decoration: InputDecoration(
            suffixIcon:
                InkWell(onTap: onTapSuffixIcon, child: Icon(suffixIcon)),
            labelText: title,
            labelStyle: TextStyle(color: AppColors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
