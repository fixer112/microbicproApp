import 'dart:convert';

import 'package:microbicpro/functions.dart';

import 'PathogenAntibiogramData.dart';

class Pathogen {
  final int id;
  final String name;
  final String overview;
  final String epidemiology;
  final String spectrum;
  //final String location;
  final List precautions;
  List<PathogenAntibiogramData> antibiogramDatas;
  List diseases;
  final String reference;

  Pathogen({
    this.name,
    this.overview,
    this.epidemiology,
    this.spectrum,
    //this.location,
    this.antibiogramDatas,
    this.id,
    this.diseases,
    this.precautions,
    this.reference,
  });

  factory Pathogen.fromMap(Map data) {
    //print(data['medicines']);
    if (isJson(data['medicines']))
      data['medicines'] = jsonDecode(data['medicines']);

    //data['medicines'] = jsonDecode(data['medicines']);

    return Pathogen(
      id: data['id'],
      name: data['name'],
      overview: data['overview'] ?? '',
      epidemiology: data['epidemiology'] ?? '',
      spectrum: data['spectrum'] ?? '',
      //location: data['location'],
      diseases: data['diseases'] ?? [],
      precautions: data['precausions'] ?? [],
      reference: data['reference'] ?? '',
      antibiogramDatas: data['medicines'] == null
          ? null
          : List<PathogenAntibiogramData>.from(data['medicines']
              .map((i) => PathogenAntibiogramData.fromMap(i))
              .toList()),
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
