import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'model/pathogen.dart';

Future<Pathogen> getPathogen(int id, BuildContext context) async {
  Pathogen pathogen;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/pathogens/$id';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    //return;
    pathogen = Pathogen.fromMap(body);

    var oldPathogens = main.getPathogens;
    oldPathogens.add(pathogen);
    main.setPathogens(oldPathogens);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    Widgets.snackbar('An Error Occured');
  }
  return pathogen;
}

Future<Medicine> getMedicine(int id, BuildContext context) async {
  Medicine medicine;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/medicines/$id';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    //return;
    medicine = Medicine.fromMap(body);

    var oldMedicines = main.getMedicines;
    oldMedicines.add(medicine);
    main.setMedicines(oldMedicines);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    Widgets.snackbar('An Error Occured');
  }
  return medicine;
}
