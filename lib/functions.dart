import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

Color getTypeColor(String type) {
  if (type == 'reserve') {
    return Colors.red;
  }
  if (type == 'access') {
    return Colors.green;
  }

  if (type == 'watch') {
    return Colors.yellow[600];
  }

  return Colors.blue;
}

storagePermission() async {
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}

Future<Directory> directory() async {
  return await getApplicationDocumentsDirectory(); //getExternalStorageDirectory();
}

Future<Null> saveJson(String content, {String fileName = 'user.json'}) async {
  await storagePermission();
  Directory appDocDir = await directory(); //getApplicationDocumentsDirectory();
  String path = appDocDir.path;
  File file = new File(path + "/" + fileName);
  file.createSync();
  file.writeAsStringSync((content));
}

Future getJson({String fileName = 'user.json'}) async {
  await storagePermission();
  Directory appDocDir = await directory();
  String path = appDocDir.path;
  var jsonFile = new File(path + "/" + fileName);
  bool fileExists = jsonFile.existsSync();
  return fileExists ? (jsonFile.readAsStringSync()) : null;
}

Future<Null> removeJson({String fileName = 'user.json'}) async {
  await storagePermission();
  Directory appDocDir = await directory();
  String path = appDocDir.path;
  var jsonFile = new File(path + "/" + fileName);
  bool fileExists = jsonFile.existsSync();
  if (fileExists) jsonFile.delete();
}

logout() async {
  await removeJson();
  await removeJson(fileName: 'users.json');
  await removeJson(fileName: 'pathogens.json');
  await removeJson(fileName: 'medicines.json');
  await removeJson(fileName: 'ebrasts.json');
  await removeJson(fileName: 'diseases.json');
  Get.off(Login());
}

isJson(string) {
  try {
    json.decode(string);
  } catch (e) {
    return false;
  }
  return true;
}
