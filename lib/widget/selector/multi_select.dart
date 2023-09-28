import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../theme.dart';
import '../../../../widget/multi_select/multi_select.dart';

class MultiSelectorWidget<T extends Object> extends StatefulWidget {
  final String label;
  final List<SelectItem<T>> items;
  final List<T> selected = [];
  final Function(List<T> selectedItems)? onSelect;
  final Widget bodyWidget;
  // final Future<void>? functionReset;

  MultiSelectorWidget({
    super.key,
    required this.label,
    required this.items,
    required this.bodyWidget,
    List<T>? selectedItems,
    this.onSelect,
    // this.functionReset,
  }) {
    if (selectedItems != null) {
      selected.addAll(selectedItems);
    }
  }

  @override
  State<MultiSelectorWidget<T>> createState() => _MultiSelectorWidgetState<T>();
}

class _MultiSelectorWidgetState<T extends Object>
    extends State<MultiSelectorWidget<T>> {
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
                Row(
                  children: [
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
                    5.w.widthBox,
                    InkWell(
                        onTap:  () async{
                          // widget.functionReset;
                        },
                        child: Icon(Remix.refresh_line, size: 18.sp,)),
                  ],
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
                backgroundColor: bgRed,
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
            child: widget.bodyWidget),
      ],
    );
  }
}
