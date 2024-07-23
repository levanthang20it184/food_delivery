import 'package:flutter/material.dart';

class AppColors{
  static final Color mainColor=hexToColor('#00FFFF');
}
Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}