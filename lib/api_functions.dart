import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:microbicpro/pages/home.dart';
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
    //link = location != null ? "$link/?location=$location" : link;
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

    var exist = oldPathogens.firstWhere((element) => element.id == id,
        orElse: () => null);

    if (exist != null) {
      oldPathogens.removeWhere((element) => element.id == id);
    }

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
    //link = location != null ? "$link/?location=$location" : link;
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

    var exist = oldMedicines.firstWhere((element) => element.id == id,
        orElse: () => null);

    if (exist != null) {
      oldMedicines.removeWhere((element) => element.id == id);
    }

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
    //link = location != null ? "$link/?location=$location" : link;
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    diseases = List<Disease>.from(body.map((i) => Disease.fromMap(i)).toList());

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

    var exist = oldDiseases.firstWhere((element) => element.id == id,
        orElse: () => null);

    if (exist != null) {
      oldDiseases.removeWhere((element) => element.id == id);
    }

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

Future<List<Ebrast>> getEbrasts(BuildContext context, {String location}) async {
  List<Ebrast> ebrasts;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/ebrasts';
    link = location != null ? "$link/?location=$location" : link;
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    ebrasts = List<Ebrast>.from(body.map((i) => Ebrast.fromMap(i)).toList());

    main.setEbrasts(ebrasts);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return ebrasts;
}

Future<Ebrast> getEbrast(int id, BuildContext context) async {
  Ebrast ebrast;
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/ebrasts/$id';
    var response = await http.get(link, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');
    //return;
    ebrast = Ebrast.fromMap(body);

    var oldEbrasts = main.getEbrasts;

    var exist = oldEbrasts.firstWhere((element) => element.id == id,
        orElse: () => null);

    if (exist != null) {
      oldEbrasts.removeWhere((element) => element.id == id);
    }
    oldEbrasts.add(ebrast);
    main.setEbrasts(oldEbrasts);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return ebrast;
}

Future login(Map<String, String> data, BuildContext context) async {
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/login';
    var response = await http.post(link, body: data, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');

    request(response, () => Get.off(Home()), context);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  //return ebrast;
}

request(Response response, Function action, context) {
  print(response.statusCode);
  var body = json.decode(response.body);
  print(body);
  return processResponse(response.statusCode, body, action, context);
}

processResponse(statusCode, body, Function action, context) {
  if (statusCode == 401) {
    Widgets.snackbar('Please re login');
    return Get.off(Login());
  }
  if (statusCode == 422) {
    var errors = '';
    body['errors'].forEach((error, data) => errors += '${data[0]}\n');
    //return snackbar(errors, context, _scaffoldKey);
    return Widgets.snackbar(errors);
  }

  if (statusCode >= 200 && statusCode < 300) {
    if (body.containsKey('error')) {
      return Widgets.snackbar(body['error']);
    }
    if (body.containsKey('success')) {
      return Widgets.snackbar(body['success']);
    }
    action();
  } else {
    return Widgets.snackbar('An error occured, Please try later.');
    /*  return snackbar(
        'An error occured, Please try later.', context, _scaffoldKey); */
  }
}
