import 'package:intl/intl.dart';
import 'dart:convert';

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
}
