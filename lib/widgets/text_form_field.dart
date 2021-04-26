import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/constants/constants.dart';
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
  final int? maxLine;
  final bool? enabled;

  VTextFormField({
    required this.title,
    required this.inputType,
    this.onTapSuffixIcon,
    this.isObscureText = false,
    this.suffixIcon,
    required this.controller,
    required this.validator,
    this.maxLine,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shadowColor: Color(0x351F54c3),
        elevation: 10,
        borderRadius: BorderRadius.circular(kSmallRadius),
        child: TextFormField(
          focusNode: FocusNode(canRequestFocus: false),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: isObscureText,
          controller: controller,
          keyboardType: inputType,
          validator: (val) => validator!(val),
          maxLines: maxLine,
          enabled: enabled,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
              suffixIcon:
                  InkWell(onTap: onTapSuffixIcon, child: Icon(suffixIcon)),
              hintText: title,
              filled: true,
              labelText: title,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }

  // decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5),
  //         boxShadow: [
  //           BoxShadow(
  //               offset: Offset(0, 6), color: Color(0x151F54C3), blurRadius: 20)
  //         ]),
}
