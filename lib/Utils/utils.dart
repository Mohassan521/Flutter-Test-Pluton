import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showToast(String message, Color? color, Color? textColor) {
    Fluttertoast.showToast(
        textColor: textColor,
        backgroundColor: color,
        toastLength: Toast.LENGTH_LONG,
        msg: message);
  }
}
