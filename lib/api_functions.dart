import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'model/disease.dart';
import 'model/pathogen.dart';

Future<List<Pathogen>> getPathogens(BuildContext context) async {
  List<Pathogen> pathogens;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/pathogens';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    pathogens =
        List<Pathogen>.from(body.map((i) => Pathogen.fromMap(i)).toList());

    main.setPathogens(pathogens);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return pathogens;
}

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

Future<List<Medicine>> getMedicines(BuildContext context) async {
  List<Medicine> medicines;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/medicines';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    medicines =
        List<Medicine>.from(body.map((i) => Medicine.fromMap(i)).toList());

    main.setMedicines(medicines);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return medicines;
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
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return medicine;
}

Future<List<Disease>> getDiseases(BuildContext context) async {
  List<Disease> diseases;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/diseases';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    diseases =
        List<Disease>.from(body.map((i) => Pathogen.fromMap(i)).toList());

    main.setDiseases(diseases);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return diseases;
}

Future<Disease> getDisease(int id, BuildContext context) async {
  Disease disease;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/diseases/$id';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    //return;
    disease = Disease.fromMap(body);

    var oldDiseases = main.getDiseases;
    oldDiseases.add(disease);
    main.setDiseases(oldDiseases);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return disease;
}
