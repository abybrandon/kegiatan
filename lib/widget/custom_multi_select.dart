import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'multi_select/multi_select.dart';

class RoleSelectorMulti<T extends Object> extends StatefulWidget {
  final String label;
  final List<SelectItem<T>> items;
  final List<T> selected = [];
  final Function(List<T> selectedItems)? onSelect;
  final Widget tittle;

  RoleSelectorMulti({
    super.key,
    required this.label,
    required this.items,
    required this.tittle,
    List<T>? selectedItems,
    this.onSelect,
  }) {
    if (selectedItems != null) {
      selected.addAll(selectedItems);
    }
  }

  @override
  State<RoleSelectorMulti<T>> createState() => _RoleSelectorMultiState<T>();
}

class _RoleSelectorMultiState<T extends Object>
    extends State<RoleSelectorMulti<T>> {
  late RxList<T> checkedItems;
  @override
  void initState() {
    checkedItems = widget.selected.obs;
    super.initState();
  }

  Widget _buildBottomSheet(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.sp,
              vertical: 10.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: headerWeak,
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkedItems.value = [];
                    setState(() {});
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: headerWeak,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: Obx(
                () => CheckboxList(
                    items: widget.items,
                    selectedItems: checkedItems,
                    onSelect: (selectedItems) {
                      checkedItems.value = selectedItems;
                    }),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.sp,
              horizontal: 24.sp,
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
                backgroundColor: bgRed, // Ganti dengan warna yang diinginkan
              ),
              onPressed: () {
                Get.back();
                setState(() {
                  widget.selected.clear();
                  widget.selected.addAll(checkedItems);
                });
                if (widget.onSelect != null) {
                  widget.onSelect!(widget.selected);
                }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: _buildBottomSheet,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 38.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: generalGrey, width: 1)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.tittle,
                  Icon(
                    FeatherIconsSnakeCase.arrow_down,
                    color: generalGrey,
                    size: 24.sp,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
