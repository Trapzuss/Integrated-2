import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as Timeago;

class ExtensionServices {
  static String capitalize(String value) {
    // print(value);
    var res = "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
    return res;
  }

  static convertTimestampToDate(timestamp) {
    DateTime time = DateTime.parse(timestamp);
    var formatter = new DateFormat('dd-MM-yyyy');
    var formatted = formatter.format(time);
    // print('formatted: $formatted');

    return formatted;
  }

  static convertTimestampToTime(timestamp) {
    DateTime time = DateTime.parse(timestamp);
    var formatter = new DateFormat('Hms');
    var formatted = formatter.format(time);
    // print('formatted: $formatted');

    return formatted;
  }

  static convertTimestampToTimeago(timestamp) {
    final now = new DateTime.now();
    DateTime time = DateTime.parse(timestamp);
    final difference = now.difference(time);
    var ago = Timeago.format(now.subtract(difference),
        locale: 'en_short', allowFromNow: true);

    return ago;
    // DateTime time = DateTime.parse(timestamp);
    // final now = DateTime.now();
    // final different = now.difference(time);

    // return Timeago.format(
    //   different,
    //   locale: 'en_short',
    //   allowFromNow: true,
    // );
  }
}
