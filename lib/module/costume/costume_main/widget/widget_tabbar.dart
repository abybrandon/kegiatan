import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';


class WidgetTabbarDuoTittle extends StatelessWidget {
  const WidgetTabbarDuoTittle({super.key, required this.tittle});
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 45.h,
        width: 150.w,
        child: Center(
          child: Text(
            tittle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: textMedium, fontWeight: Config.reguler),
          ),
        ));
  }
}
