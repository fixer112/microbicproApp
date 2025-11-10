import 'dart:convert';

import 'DrugManagement.dart';
import 'model_utils.dart';

class Disease {
  final int id;
  final String name;
  final String overview;
  final String category;
  final String features;
  final String treatmentObjectives;
  final String location;
  final List<DrugManagement> drugManagements;

  const Disease({
    required this.id,
    required this.name,
    required this.overview,
    required this.category,
    required this.features,
    required this.treatmentObjectives,
    required this.location,
    required this.drugManagements,
  });

  factory Disease.fromMap(Map<String, dynamic> data) {
    return Disease(
      id: parseInt(data['id']),
      name: parseString(data['name']),
      overview: parseString(data['overview']),
      location: parseString(data['location']),
      category: parseString(data['category']),
      treatmentObjectives: parseString(data['treatment_objectives']),
      features: parseString(data['features']),
      drugManagements: buildModelList(
        data['drug_managements'],
        DrugManagement.fromMap,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'location': location,
        'features': features,
        'treatment_objectives': treatmentObjectives,
        'category': category,
        'drug_managements': jsonEncode(drugManagements),
      };
}
