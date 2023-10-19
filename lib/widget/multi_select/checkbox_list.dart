part of 'multi_select.dart';

class CheckboxList<T extends Object> extends StatefulWidget {
  final List<SelectItem<T>> items;
  final List<T> selected = [];
  final Function(List<T> selectedItems)? onSelect;

  CheckboxList({
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
  State<CheckboxList> createState() => _CheckboxListState<T>();
}

class _CheckboxListState<T extends Object> extends State<CheckboxList<T>> {
  final TextEditingController searchController = TextEditingController();

  bool getIsItemSelect(T value) {
    return widget.selected.contains(value);
  }

  List<SelectItem<T>> get filteredItems {
    final regex = RegExp(
      searchController.text,
      caseSensitive: false,
    );

    return widget.items
        .where(
          (item) => regex.hasMatch(item.label),
        )
        .toList();
  }

  @override
  void initState() {
    print(widget.selected);
    searchController.addListener(
      () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          style: TextStyle(fontSize: 12.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.sp),
            border: const UnderlineInputBorder(),
            isDense: true,
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 12.sp),
            suffixIcon: Icon(
              FeatherIcons.search,
              size: 25.sp,
              color: bgRed,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: filteredItems.map(
              (item) {
                return InkWell(
                  onTap: () {
                    setState(
                      () {
                        if (!getIsItemSelect(item.value)) {
                          widget.selected.add(item.value);
                        } else {
                          widget.selected.remove(item.value);
                        }
                      },
                    );

                    if (widget.onSelect != null) {
                      widget.onSelect!(widget.selected);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.label),
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            activeColor: bgRed,
                            value: getIsItemSelect(item.value),
                            onChanged: (value) {
                              setState(
                                () {
                                  if (value!) {
                                    widget.selected.add(item.value);
                                  } else {
                                    widget.selected.remove(item.value);
                                  }
                                },
                              );

                              if (widget.onSelect != null) {
                                widget.onSelect!(widget.selected);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
