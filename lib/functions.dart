import 'package:flutter/material.dart';

Color getColor(double per) {
  if (per < 50) {
    return Colors.red;
  } else if (per > 70) {
    return Colors.green;
  }
  return Colors.yellow[600];
}

String getText(double per) {
  if (per < 50) {
    return '${per}R';
  } else if (per > 70) {
    return '${per}A';
  }
  return '${per}W';
}
