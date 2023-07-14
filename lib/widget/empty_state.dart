import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/no_data.jpg',
          width: 165.w,
          height: 165.h,
        ),
        const Text('No Records Found'),
        SizedBox(
          height: 50.h,
        )
      ],
    );
  }
}
