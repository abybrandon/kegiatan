part of 'multi_select.dart';

class BadgeSelectorField<T extends Object> extends StatefulWidget {
  final String label;
  final List<SelectItem<T>> items;
  final List<T> selected = [];
  final Function(List<T> selectedItems)? onSelect;

  BadgeSelectorField({
    super.key,
    required this.label,
    required this.items,
    List<T>? selectedItems,
    this.onSelect,
  }) {
    if (selectedItems != null) {
      selected.addAll(selectedItems);
    }
  }

  @override
  State<BadgeSelectorField<T>> createState() => _BadgeSelectorFieldState<T>();
}

class _BadgeSelectorFieldState<T extends Object>
    extends State<BadgeSelectorField<T>> {
  Widget _buildBottomSheet(BuildContext context) {
    final RxList<T> checkedItems = widget.selected.obs;

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
                  onSelect: (selectedItems) =>
                      checkedItems.value = selectedItems,
                ),
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
              style: ElevatedButton.styleFrom(primary: bgRed),
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
        Container(
          margin: EdgeInsets.only(bottom: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: const TextStyle(color: headerWeak),
              ),
              widget.items.length > 5
                  ? InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: _buildBottomSheet,
                        );
                      },
                      splashColor: bgBlue.withOpacity(0.1),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: bgRed,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        BadgeSelectList(
          items: widget.items,
          selectedItems: widget.selected,
          onSelect: (selectedItems) {
            widget.selected.clear();
            widget.selected.addAll(selectedItems);
            if (widget.onSelect != null) {
              widget.onSelect!(widget.selected);
            }
          },
        ),
      ],
    );
  }
}
