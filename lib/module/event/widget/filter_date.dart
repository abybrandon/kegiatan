import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import '../../../theme.dart';

class FilterDateEvent extends GetView<EventController> {
  const FilterDateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => RadioListTile<int>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Semua Tanggal',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: Config.reguler)),
                value: 1,
                groupValue: controller.selectedValue.value,
                onChanged: (value) => controller.radioOnchange(value, context)),
          ),
          Obx(
            () => RadioListTile<int>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Minggu Ini',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: Config.reguler)),
                value: 2,
                groupValue: controller.selectedValue.value,
                onChanged: (value) => controller.radioOnchange(value, context)),
          ),
          Obx(
            () => RadioListTile<int>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Bulan Ini',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: Config.reguler)),
                value: 3,
                groupValue: controller.selectedValue.value,
                onChanged: (value) => controller.radioOnchange(value, context)),
          ),
          Obx(
            () => RadioListTile<int>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Custom Tanggal',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: Config.reguler)),
                value: 4,
                groupValue: controller.selectedValue.value,
                onChanged: (value) => controller.radioOnchange(value, context)),
          ),
          8.h.heightBox,
          Obx(() => controller.selectedValue.value == 4
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: InkWell(
                    onTap: () {
                      controller.datePickerRange(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${controller.customFirstDate.value != null ? DateFormat("dd/MM/yyyy").format(controller.firstValueDate!) : '-'} ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: Config.semiBold)),
                        Text(
                            '${controller.customLastDate.value != null ? DateFormat("dd/MM/yyyy").format(controller.endValueDate!) : '-'} ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: Config.semiBold)),
                      ],
                    ),
                  ),
                )
              : SizedBox()),
          8.h.heightBox,
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.sp,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: generalLine,
                  width: 1.sp,
                ),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgRed,
              ),
              onPressed: () {
                controller.onFilterDate(context);
                Get.back();
              },
              child: const Text(
                'Apply',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
