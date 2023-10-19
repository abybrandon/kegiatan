part of 'multi_select.dart';

class BadgeSelectList<T extends Object> extends StatefulWidget {
  final List<SelectItem<T>> items;
  final List<T> selected = [];
  final Function(List<T> selectedItems)? onSelect;

  BadgeSelectList({
    super.key,
    required this.items,
    List<T>? selectedItems,
    this.onSelect,
  }) {
    if (selectedItems != null) {
      selected.addAll(selectedItems);
    }
  }

  @override
  State<BadgeSelectList> createState() => _BadgeSelectListState<T>();
}

class _BadgeSelectListState<T extends Object>
    extends State<BadgeSelectList<T>> {
  bool getIsItemSelected(T value) {
    return widget.selected.contains(value);
  }

  List<SelectItem<T>> get showedItems {
    final unSelectedItems = widget.items.where(
      (item) => !widget.selected.contains(item.value),
    );
    final selectedItems = widget.selected.map(
      (selected) => widget.items.firstWhere(
        (item) => item.value == selected,
      ),
    );
    return [...selectedItems, ...unSelectedItems];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.sp,
            runSpacing: 8.sp,
            children: [
              ...showedItems.take(5).map(
                (item) {
                  final isSelected = getIsItemSelected(item.value);

                  return _SelectBadge(
                    label: item.label,
                    isSelected: isSelected,
                    onTap: () {
                      if (!isSelected) {
                        widget.selected.add(item.value);
                      } else {
                        widget.selected.remove(item.value);
                      }
                      setState(() {});

                      if (widget.onSelect != null) {
                        widget.onSelect!(widget.selected);
                      }
                    },
                  );
                },
              ).toList(),
              widget.selected.length > 5
                  ? Container(
                      margin: EdgeInsets.only(bottom: 8.sp),
                      child: Text(
                        '+${widget.selected.length - 5} more',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: generalGrey,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectBadge extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onTap;

  const _SelectBadge({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: bgRed.withOpacity(0.2),
      customBorder: const StadiumBorder(),
      child: CustomBadge(
        title: label,
        color: isSelected ? bgRed : generalGrey,
        backgroundColor: Colors.transparent,
        style: TextStyle(fontSize: 14.sp),
        padding: EdgeInsets.symmetric(
          vertical: 6.sp,
          horizontal: 12.sp,
        ),
      ),
    );
  }
}
