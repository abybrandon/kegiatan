part of 'date_picker.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(DateTime date) onDateChange;
  final DateTime? selectedDate;

  const CustomDatePicker(
      {super.key, required this.onDateChange, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.sp,
      child: ScrollDatePicker(
        locale: const Locale('en'),
        selectedDate: selectedDate ?? DateTime.now(),
        maximumDate: DateTime.now().add(const Duration(days: 10000)),
        scrollViewOptions: DatePickerScrollViewOptions(
          day: ScrollViewDetailOptions(
            margin: EdgeInsets.only(right: 60.sp),
          ),
          month: ScrollViewDetailOptions(
            margin: EdgeInsets.only(right: 60.sp),
            textStyle: const TextStyle(fontFamily: 'Poppins'),
            selectedTextStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        options: DatePickerOptions(
          // diameterRatio: 100.sp,
          itemExtent: 50.sp,
          backgroundColor: Colors.white,
        ),
        onDateTimeChanged: onDateChange,
      ),
    );
  }
}
