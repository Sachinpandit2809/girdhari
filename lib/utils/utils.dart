import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastErrorMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14);

    
  }

  void toastSuccessMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.green,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 14);
  }
}
