import 'package:flutter/material.dart';

class Toast{
  static showToast({required BuildContext context, required String message, bool isWarning=false}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isWarning?Colors.red: Colors.green,
      ),
    );
  }
}