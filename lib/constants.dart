import 'package:flutter/material.dart';

var decorationTextFeild = const InputDecoration(
  hintText: 'Enter Your Email: ',
  fillColor: Color.fromARGB(255, 219, 219, 219),
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
     borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
  errorBorder:  OutlineInputBorder(
     borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
);
