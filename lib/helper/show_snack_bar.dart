  import 'package:flutter/material.dart';

showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Close', onPressed: () {}),
      ),
    );
  }