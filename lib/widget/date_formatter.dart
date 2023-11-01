import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateUtil {
  String formatTimestamps(Timestamp? startDate, Timestamp? endDate) {
    if (startDate != null) {
      try {
        final startDateTime = startDate.toDate();
        final endDateTime = endDate?.toDate();
        initializeDateFormatting('id_ID');
        final format = DateFormat('dd MMMM yyyy', 'id_ID');

        if (endDateTime != null) {
          final formattedStartDate = format.format(startDateTime);
          final formattedEndDate = format.format(endDateTime);

          // Mendapatkan hanya tanggal dari tanggal mulai dan selesai
          final startDateDay = startDateTime.day;
          final endDateDay = endDateTime.day;

          return '$startDateDay - $endDateDay ${formattedStartDate.substring(3)}';
        } else {
          final formattedStartDate = format.format(startDateTime);
          return formattedStartDate;
        }
      } catch (e) {
        return 'Fail Convert';
      }
    } else {
      return 'null';
    }
  }
}
