import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import '../multi_select/multi_select.dart';

class SingleSelect<T extends Object> extends StatefulWidget {
  final List<SelectItem<T>> items;
  final Function(T? selectedItem)? onSelect;

  SingleSelect({
    Key? key,
    required this.items,
    this.onSelect,
  }) : super(key: key);

  @override
  State<SingleSelect> createState() => _SingleSelectState<T>();
}

class _SingleSelectState<T extends Object> extends State<SingleSelect<T>> {
  final TextEditingController searchController = TextEditingController();
  T? selectedValue;

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp),
          child: TextField(
            controller: searchController,
            style: TextStyle(fontSize: 12.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.sp),
              border: const UnderlineInputBorder(),
              isDense: true,
              hintText: 'Search...',
              hintStyle: TextStyle(fontSize: 12.sp),
              suffixIcon: Icon(
                Icons.search,
                size: 25.sp,
                color: Colors.blue,
              ),
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
                        selectedValue = item.value;
                      },
                    );

                    if (widget.onSelect != null) {
                      widget.onSelect!(selectedValue);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                              color: selectedValue == item.value
                                  ? bgRed
                                  : basicBlack),
                        ),
                        if (selectedValue == item.value)
                          Icon(
                            Icons.check,
                            color: bgRed,
                            size: 24.sp,
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
