import 'model_utils.dart';

class MedicineAntiBiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int? pathogenId;
  final String pathogenName;
  final String sample;
  final int referenceId;
  final String location;

  const MedicineAntiBiogramData({
    required this.id,
    required this.isolateNumber,
    required this.year,
    required this.percentage,
    required this.pathogenId,
    required this.pathogenName,
    required this.sample,
    required this.referenceId,
    required this.location,
  });

  factory MedicineAntiBiogramData.fromMap(Map<String, dynamic> data) {
    final rawPivot = data['pivot'];
    final pivot = rawPivot is Map
        ? Map<String, dynamic>.from(
            rawPivot,
          )
        : <String, dynamic>{};

    return MedicineAntiBiogramData(
      id: parseInt(pivot['id']),
      isolateNumber: parseString(pivot['isolate_number']),
      year: parseString(pivot['year']),
      percentage: parseString(pivot['percentage']),
      pathogenId:
          pivot['pathogen_id'] == null ? null : parseInt(pivot['pathogen_id']),
      pathogenName: parseString(data['name']),
      sample: parseString(pivot['sample']),
      referenceId: parseInt(pivot['reference_id']),
      location: parseString(pivot['location']),
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
          'reference_id': referenceId,
          'location': location,
        },
        'name': pathogenName,
      };
}
