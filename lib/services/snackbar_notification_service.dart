import 'package:flutter/material.dart';

class SnackBarNotificationService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
