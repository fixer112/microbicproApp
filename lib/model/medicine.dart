import 'dart:convert';

import 'MedicineAntiBiogramData.dart';
import 'model_utils.dart';

class Medicine {
  final int id;
  final String name;
  final String overview;
  final String avgCost;
  final String brand;
  final String type;
  final String drugClass;
  final String action;
  final String pharmacokinetics;
  final String interactions;
  final String pregnancyCategory;
  final String adverseEffects;
  final String renal;
  final String adult;
  final String child;
  final String spectrum;
  //final String location;
  final String reference;
  final List<MedicineAntiBiogramData> antibiogramDatas;

  const Medicine({
    required this.id,
    required this.name,
    required this.overview,
    required this.avgCost,
    required this.spectrum,
    required this.action,
    required this.adult,
    required this.adverseEffects,
    required this.brand,
    required this.child,
    required this.drugClass,
    required this.interactions,
    required this.pharmacokinetics,
    required this.pregnancyCategory,
    required this.renal,
    required this.type,
    required this.reference,
    List<MedicineAntiBiogramData>? antibiogramDatas,
  }) : antibiogramDatas = antibiogramDatas ?? const [];

  factory Medicine.fromMap(Map<String, dynamic> data) {
    return Medicine(
      id: parseInt(data['id']),
      name: parseString(data['name']),
      overview: parseString(data['overview']),
      avgCost: parseString(data['avg_cost']),
      spectrum: parseString(data['spectrum']),
      action: parseString(data['action']),
      adult: parseString(data['adult']),
      adverseEffects: parseString(data['adverse_effects']),
      brand: parseString(data['brand']),
      child: parseString(data['child']),
      drugClass: parseString(data['drug_class']),
      interactions: parseString(data['interactions']),
      pharmacokinetics: parseString(data['pharmacokinetics']),
      pregnancyCategory: parseString(data['pregnancy_category']),
      renal: parseString(data['renal']),
      type: parseString(data['type']),
      reference: parseString(data['reference']),
      antibiogramDatas: buildModelList(
        data['pathogens'],
        MedicineAntiBiogramData.fromMap,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'action': action,
        'adult': adult,
        'adverse_effects': adverseEffects,
        'brand': brand,
        'child': child,
        'drug_class': drugClass,
        'interactions': interactions,
        'pharmacokinetics': pharmacokinetics,
        'renal': renal,
        'type': type,
        'pathogens': jsonEncode(antibiogramDatas),
        'name': name,
        'overview': overview,
        'avg_cost': avgCost,
        'spectrum': spectrum,
        //'location': location,
        'reference': reference,
      };
}
