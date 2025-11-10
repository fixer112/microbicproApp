import 'dart:convert';

import 'PathogenAntibiogramData.dart';
import 'model_utils.dart';

class Pathogen {
  final int id;
  final String name;
  final String overview;
  final String epidemiology;
  final String spectrum;
  //final String location;
  final List<Map<String, dynamic>> precautions;
  final List<PathogenAntibiogramData> antibiogramDatas;
  final List<Map<String, dynamic>> diseases;
  final String reference;

  const Pathogen({
    required this.id,
    required this.name,
    required this.overview,
    required this.epidemiology,
    required this.spectrum,
    required this.antibiogramDatas,
    required this.diseases,
    required this.precautions,
    required this.reference,
  });

  factory Pathogen.fromMap(Map<String, dynamic> data) {
    return Pathogen(
      id: parseInt(data['id']),
      name: parseString(data['name']),
      overview: parseString(data['overview']),
      epidemiology: parseString(data['epidemiology']),
      spectrum: parseString(data['spectrum']),
      diseases: mapList(data['diseases']),
      precautions: mapList(data['precausions']),
      reference: parseString(data['reference']),
      antibiogramDatas: buildModelList(
        data['medicines'],
        PathogenAntibiogramData.fromMap,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'epidemiology': epidemiology,
        'spectrum': spectrum,
        //'location': location,
        'medicines': jsonEncode(antibiogramDatas),
        'diseases': diseases,
        'precausions': precautions,
        'reference': reference,
      };
}
