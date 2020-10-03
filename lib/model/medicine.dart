import 'package:microbicpro/provider/main.dart';
import 'package:provider/provider.dart';

import 'MedicineAntiBiogramData.dart';

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
  List<MedicineAntiBiogramData> antibiogramDatas;

  Medicine({
    this.id,
    this.name,
    this.overview,
    this.avgCost,
    this.spectrum,
    //this.location,
    this.action,
    this.adult,
    this.adverseEffects,
    this.brand,
    this.antibiogramDatas,
    this.child,
    this.drugClass,
    this.interactions,
    this.pharmacokinetics,
    this.pregnancyCategory,
    this.renal,
    this.type,
    this.reference,
  });

  factory Medicine.fromMap(Map data) {
    return Medicine(
        id: data['id'],
        name: data['name'],
        overview: data['overview'],
        avgCost: data['avg_cost'],
        spectrum: data['spectrum'],
        //location: data['location'],
        action: data['action'],
        adult: data['adult'],
        adverseEffects: data['adverse_effects'],
        brand: data['brand'],
        child: data['child'],
        drugClass: data['drug_class'],
        interactions: data['interactions'],
        pharmacokinetics: data['pharmacokinetics'],
        pregnancyCategory: data['pregnancy_category'],
        renal: data['renal'],
        type: data['type'],
        reference: data['reference'],
        antibiogramDatas: List<MedicineAntiBiogramData>.from(data['pathogens']
            .map((i) => MedicineAntiBiogramData.fromMap(i))
            .toList()));
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
        'pathogens': antibiogramDatas,
        'name': name,
        'overview': overview,
        'avg_cost': avgCost,
        'spectrum': spectrum,
        //'location': location,
        'reference': reference,
      };
}
