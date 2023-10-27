part of 'date_picker.dart';

class DateSelector extends StatefulWidget {
  final Function(String selectedOption, List<DateTime>? date)? onApply;
  final String? selectedRange;
  final List<DateTime>? customDateSelected;

  const DateSelector({
    super.key,
    this.onApply,
    this.selectedRange,
    this.customDateSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String selectedRange = 'all';
  final List<DateTime> customDateSelected = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
  ];
  final DateFormat dateFormat = DateFormat('d/M/y', 'en_US');

  List<DateTime>? get selectedDateRange {
    if (selectedRange == 'custom') {
      return customDateSelected;
    } else if (selectedRange == 'last_30_days') {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day + 1);

      return [
        today.subtract(const Duration(days: 30)),
        today,
      ];
    } else if (selectedRange == 'last_7_days') {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day + 1);

      return [
        today.subtract(const Duration(days: 7)),
        today,
      ];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    if (widget.selectedRange != null) {
      selectedRange = widget.selectedRange!;
    }

    if (widget.customDateSelected != null &&
        widget.customDateSelected!.isNotEmpty) {
      customDateSelected.clear();
      customDateSelected.addAll(widget.customDateSelected!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedRange = 'all';
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Date',
                  style: TextStyle(color: generalBody),
                ),
                Radio<String>(
                  value: 'all',
                  groupValue: selectedRange,
                  onChanged: (value) {
                    setState(() {
                      selectedRange = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedRange = 'last_7_days';
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Last 7 Days',
                  style: TextStyle(color: generalBody),
                ),
                Radio<String>(
                  value: 'last_7_days',
                  groupValue: selectedRange,
                  onChanged: (value) {
                    setState(() {
                      selectedRange = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedRange = 'last_30_days';
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Last 30 Days',
                  style: TextStyle(color: generalBody),
                ),
                Radio<String>(
                  value: 'last_30_days',
                  groupValue: selectedRange,
                  onChanged: (value) {
                    setState(() {
                      selectedRange = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedRange = 'custom';
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Custom Date',
                  style: TextStyle(color: generalBody),
                ),
                Radio<String>(
                  value: 'custom',
                  groupValue: selectedRange,
                  onChanged: (value) {
                    setState(() {
                      selectedRange = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        selectedRange == 'custom'
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: generalLabel,
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Container(
                          constraints: BoxConstraints(minWidth: 40.sp),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return CustomDateSelectorBottomSheet(
                                    label: 'From',
                                    selectedDate: customDateSelected[0],
                                    onApply: (selectedDateTime) {
                                      setState(() {
                                        customDateSelected[0] =
                                            selectedDateTime;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              dateFormat.format(customDateSelected[0]),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: generalBody,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: generalLabel,
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomDateSelectorBottomSheet(
                                  label: 'To',
                                  selectedDate: customDateSelected[1],
                                  onApply: (selectedDateTime) {
                                    setState(() {
                                      customDateSelected[1] = selectedDateTime;
                                    });
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            dateFormat.format(customDateSelected[1]),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: generalBody,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        Container(
          margin: EdgeInsets.only(top: 10.sp),
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: generalLine,
                width: 0.5.sp,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.sp,
              ),
            ],
          ),
          child: ElevatedButton(
            style:  ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: bgRed, // Atur warna teks menjadi putih
              ),
            onPressed: () {
              if (selectedRange == 'custom' &&
                  customDateSelected[1].isBefore(customDateSelected[0])) {
                Toast.showErrorToastWithoutContext(
                    'Error set date. Date to must be after date from');
                return;
              }

              if (widget.onApply != null) {
                widget.onApply!(selectedRange, selectedDateRange);
              }
            },
            child:  Text('Apply', style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          ),
        ),
      ],
    );
  }
}

class CustomDateSelectorBottomSheet extends StatefulWidget {
  final String label;
  final Function(DateTime selectedDateTime) onApply;
  final DateTime? selectedDate;

  const CustomDateSelectorBottomSheet({
    super.key,
    required this.label,
    required this.onApply,
    this.selectedDate,
  });

  @override
  State<CustomDateSelectorBottomSheet> createState() =>
      CustomDateSelectorBottomSheetState();
}

class CustomDateSelectorBottomSheetState
    extends State<CustomDateSelectorBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: headerWeak,
              ),
            ),
          ),
          CustomDatePicker(
            selectedDate: widget.selectedDate,
            onDateChange: (value) {
              selectedDate = value;
            },
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24.sp, 10.sp, 24.sp, 22.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: generalLine,
                  width: 1.sp,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: bgRed, 
              ),
              onPressed: () {
                widget.onApply(selectedDate);
                Get.back();
              },
              child:  Text('Apply', style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
