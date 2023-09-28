import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isError;
  final String errorText;
  final Function(String value)? onSubmitted;
  final TextStyle? style;
  final InputBorder? borderStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final bool autoFocus;
  final IconData? icon;
  final bool? isObscure;
  final VoidCallback? iconFunction;
  final double? maxWidth;
  final bool digitOnly;

  const CustomTextField(
      {super.key,
      this.controller,
      required this.errorText,
      this.isError = false,
      this.isObscure = false,
      this.onSubmitted,
      this.borderStyle,
      this.style,
      this.hintText,
      this.hintStyle,
      this.padding,
      this.autoFocus = false,
      this.iconFunction,
      this.maxWidth,
      this.digitOnly = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final errorInputBorder = borderStyle != null
        ? borderStyle!.copyWith(
            borderSide: BorderSide(
              color: dangerDefault,
              width: 1.w,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: dangerDefault,
              width: 1.w,
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 43.h,
          width:  maxWidth,
          child: TextField(
            inputFormatters:  digitOnly? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly         ] :null,
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              color: isError ? dangerDefault : Colors.grey[700],
              fontWeight: Config.medium,
            ).merge(style),
            decoration: InputDecoration(
              suffixIcon: icon != null ? 
              InkWell(
                onTap: iconFunction ,
                child: Icon(
                  icon,
                  size: 24.sp,
                ),
              ) : null,
              border: borderStyle ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: Config.medium,
                  color: Colors.grey[500]),
              fillColor: Color(0xff8A8A8A).withOpacity(0.3),
              filled: true,
              enabledBorder: isError ? errorInputBorder : null,
              focusedBorder: isError ? errorInputBorder : null,
              contentPadding: padding ??
                  EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
              isDense: true,
            ),
            autofocus: autoFocus,
            onSubmitted: onSubmitted,
            obscureText: isObscure ?? false,
          ),
        ),
        isError
            ? Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(
                  errorText,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: dangerDefault.withOpacity(0.7),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
