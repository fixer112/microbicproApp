import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/model/user.dart';
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
    pathogens.sort((a, b) => a.name.compareTo(b.name));
    main.setPathogens(pathogens);
    saveJson(jsonEncode(pathogens), fileName: 'pathogens.json');
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
    saveJson(jsonEncode(oldPathogens), fileName: 'pathogens.json');
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

    medicines.sort((a, b) => a.name.compareTo(b.name));
    main.setMedicines(medicines);
    saveJson(jsonEncode(medicines), fileName: 'medicines.json');
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
    saveJson(jsonEncode(oldMedicines), fileName: 'medicines.json');
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
  //try {
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
  diseases.sort((a, b) => a.name.compareTo(b.name));
  main.setDiseases(diseases);
  saveJson(jsonEncode(diseases), fileName: 'diseases.json');
  /* } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  } */
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
    //print('Response body: ${body['drug_managements'][0]['medicine_name']}');
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
    saveJson(jsonEncode(oldDiseases), fileName: 'diseases.json');
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
    ebrasts.sort((a, b) => a.location.compareTo(b.location));
    saveJson(jsonEncode(ebrasts), fileName: 'ebrasts.json');
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
    saveJson(jsonEncode(oldEbrasts), fileName: 'ebrasts.json');
    main.setEbrasts(oldEbrasts);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  return ebrast;
}

Future login(Map data, BuildContext context, {refresh: false}) async {
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/login';
    var response = await http.post(link, body: data, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');

    request(response, () async {
      var user = User.fromMap(body);
      main.setUser(user);

      saveJson(jsonEncode(data));
      saveJson(jsonEncode(user), fileName: 'users.json');

      //await updateBox('credentials', Map<String, dynamic>.from(data));
      //print(data);

      if (!refresh) Get.off(Home());
    }, context);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  //return ebrast;
}

Future register(Map data, BuildContext context) async {
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link = '$url/api/register';
    var response = await http.post(link, body: data, headers: {
      'Accept': 'application/json',
    });
    var body = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${body}');

    request(response, () async {
      main.setUser(User.fromMap(body));
      saveJson(json.encode(data));
      await login(data, context);

      //Get.off(Home());
    }, context);
  } on SocketException {
    Widgets.snackbar('Please Connect to the internet');
  } catch (e) {
    print(e);
    Widgets.snackbar('An Error Occured');
  }
  //return ebrast;
}

Future changeLocation(String location, BuildContext context) async {
  try {
    var main = Provider.of<MainModel>(context, listen: false);

    var link =
        '$url/api/user/${main.getUser.id}/location?api_token=${main.getUser.apiToken}';
    var response = await http.post(link, body: {
      'location': location
    }, headers: {
      'Accept': 'application/json',
    });

    print('Response status: ${response.statusCode}');

    request(response, () async {
      //var data = await getJson();
      //await login(jsonDecode(data), context, refresh: true);
      Widgets.snackbar('Location changed');
    }, context);
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
