import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/model/user.dart';

import '../functions.dart';

class MainModel extends ChangeNotifier {
  User user;
  List<Pathogen> pathogens = [];
  List<Medicine> medicines = [];
  List<Disease> diseases = [];
  List<Ebrast> ebrasts = [];

  setPathogens(List<Pathogen> newPathogens) {
    saveJson(jsonEncode(newPathogens), fileName: 'pathogens.json');
    pathogens = newPathogens;
    notifyListeners();
  }

  Future<List<Pathogen>> getPathogens() async {
    var p = await getJson(fileName: 'pathogens.json');
    if (p != null) {
      pathogens = List<Pathogen>.from(p.map((i) => Ebrast.fromMap(i)).toList());
    }
    return pathogens;
  }

  setMedicines(List<Medicine> newMedicines) {
    saveJson(jsonEncode(newMedicines), fileName: 'medicines.json');
    medicines = newMedicines;
    notifyListeners();
  }

  Future<List<Medicine>> getMedicines() async {
    var m = await getJson(fileName: 'medicines.json');
    if (m != null) {
      medicines = List<Medicine>.from(m.map((i) => Ebrast.fromMap(i)).toList());
    }
    return medicines;
  }

  setDiseases(List<Disease> newDiseases) {
    saveJson(jsonEncode(newDiseases), fileName: 'diseases.json');
    diseases = newDiseases;
    notifyListeners();
  }

  Future<List<Disease>> getDiseases() async {
    var d = await getJson(fileName: 'diseases.json');
    if (d != null) {
      diseases = List<Disease>.from(d.map((i) => Ebrast.fromMap(i)).toList());
    }
    return diseases;
  }

  setEbrasts(List<Ebrast> newEbrasts) {
    saveJson(jsonEncode(newEbrasts), fileName: 'ebrasts.json');
    ebrasts = newEbrasts;
    notifyListeners();
  }

  Future<List<Ebrast>> getEbrasts() async {
    var e = await getJson(fileName: 'ebrasts.json');
    if (e != null) {
      ebrasts = List<Ebrast>.from(e.map((i) => Ebrast.fromMap(i)).toList());
    }
    return ebrasts;
  }

  setUser(User newUser) {
    saveJson(jsonEncode(newUser));
    user = newUser;
    notifyListeners();
  }

  Future<User> getUser() async {
    var u = await getJson();
    if (u != null) {
      user = User.fromMap(json.decode(u));
    }
    return user;
  }
}
