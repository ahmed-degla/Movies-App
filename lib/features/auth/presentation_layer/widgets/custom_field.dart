import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';

class CustomField extends StatefulWidget {
  final Widget prefix;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomField({
    super.key,
    required this.prefix,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    validator: widget.validator,
    keyboardType: widget.keyboardType,
    obscureText: widget.isPassword && !isPasswordVisible,
    decoration:
      InputDecoration(
        filled: true,
        enabledBorder:
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: appColors.primaryText,fontWeight: FontWeight.w400 ,fontSize: widget.isPassword ?15.sp :16.sp),
        prefixIcon: Padding(
          padding: REdgeInsets.only(
            right: 8.w,
            left:15.w
          ),
          child: widget.prefix,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 50.h, maxWidth: 50.w),
        suffixIcon: widget.isPassword ? InkWell(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            child:Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),

    );
}
