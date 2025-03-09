import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy.MM.dd').format(date);
  }

  static String formatTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('HH:mm').format(date);
  }

  static String formatRelativeTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();

    Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return formatTime(timestamp);
    } else if (difference.inDays == 1) {
      return "하루 전";
    } else if (difference.inDays == 2) {
      return "이틀 전";
    } else if (difference.inDays >= 30 && difference.inDays < 365) {
      return "한 달 전";
    } else if (difference.inDays >= 365) {
      return "1년 전";
    } else {
      return formatDate(timestamp);
    }
  }
}
