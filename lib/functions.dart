import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:path_provider/path_provider.dart';

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

Future<Null> saveJson(String content, {String fileName = 'user.json'}) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = appDocDir.path;
  File file = new File(path + "/" + fileName);
  file.createSync();
  file.writeAsStringSync((content));
}

Future getJson({String fileName = 'user.json'}) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = appDocDir.path;
  var jsonFile = new File(path + "/" + fileName);
  bool fileExists = jsonFile.existsSync();
  return fileExists ? (jsonFile.readAsStringSync()) : null;
}

Future<Null> removeJson({String fileName = 'user.json'}) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = appDocDir.path;
  var jsonFile = new File(path + "/" + fileName);
  bool fileExists = jsonFile.existsSync();
  if (fileExists) jsonFile.delete();
}

logout() {
  removeJson();
  Get.off(Login());
}
