class ExtensionServices {
  static String capitalize(String value) {
    // print(value);
    var res = "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
    return res;
  }
}
