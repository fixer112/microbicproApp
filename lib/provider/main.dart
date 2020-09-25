import 'package:flutter/material.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/model/pathogen.dart';

class MainModel extends ChangeNotifier {
  List<Pathogen> pathogens = [];
  List<Medicine> medicines = [];

  setPathogens(List<Pathogen> newPathogens) {
    pathogens = newPathogens;
    notifyListeners();
  }

  List<Pathogen> get getPathogens => pathogens;

  setMedicines(List<Medicine> newMedicines) {
    medicines = newMedicines;
    notifyListeners();
  }

  List<Medicine> get getMedicines => medicines;
}
