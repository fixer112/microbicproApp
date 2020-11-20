import 'package:microbicpro/model/pathogen.dart';

class MedicineAntiBiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int pathogenId;
  final String pathogenName;
  final String sample;
  final int referenceID;
  final String location;

  MedicineAntiBiogramData({
    this.isolateNumber,
    this.percentage,
    this.year,
    this.pathogenId,
    this.pathogenName,
    this.id,
    this.sample,
    this.referenceID,
    this.location,
  });

  factory MedicineAntiBiogramData.fromMap(Map data) {
    return MedicineAntiBiogramData(
      id: int.parse(data['pivot']['id'].toString()),
      isolateNumber: data['pivot']['isolate_number'] ?? '',
      year: data['pivot']['year'] ?? '',
      percentage: data['pivot']['percentage'] ?? '',
      pathogenId: data['pivot']['pathogen_id'] == null
          ? null
          : int.parse(data['pivot']['pathogen_id'].toString()),
      pathogenName: data['name'] ?? '',
      sample: data['pivot']['sample'] ?? '',
      referenceID: int.parse(data['pivot']['reference_id'].toString()),
      location: data['pivot']['location'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'pivot': {
          'id': id,
          'isolate_number': isolateNumber,
          'year': year,
          'percentage': percentage,
          'pathogen_id': pathogenId,
          'sample': sample,
          'reference_id': referenceID,
          'location': location,
        },
        'name': pathogenName,
      };
}
