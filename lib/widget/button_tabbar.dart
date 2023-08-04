import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme.dart';

class ButtonTabbar extends StatelessWidget {
  const ButtonTabbar(
      {super.key,
      required this.tittle,
      required this.function,
      required this.isSelected});
  final String tittle;
  final VoidCallback function;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
          decoration: BoxDecoration(
              border: Border.all(color: bgRed),
              borderRadius: BorderRadius.circular(6),
              color: isSelected ? bgRed : bgWhite),
          child: Text(
            tittle,
            style: TextStyle(
                fontSize: textMedium,
                color: isSelected ? bgWhite : bgRed,
                fontWeight: Config.medium),
          ),
        ),
      ),
    );
  }
}
