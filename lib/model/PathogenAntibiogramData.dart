import 'model_utils.dart';

class PathogenAntibiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int medicineId;
  final String medicineName;
  final String sample;
  final int referenceId;
  final String location;

  const PathogenAntibiogramData({
    required this.id,
    required this.isolateNumber,
    required this.year,
    required this.percentage,
    required this.medicineId,
    required this.medicineName,
    required this.sample,
    required this.referenceId,
    required this.location,
  });

  factory PathogenAntibiogramData.fromMap(Map<String, dynamic> data) {
    final rawPivot = data['pivot'];
    final pivot = rawPivot is Map
        ? Map<String, dynamic>.from(
            rawPivot,
          )
        : <String, dynamic>{};

    return PathogenAntibiogramData(
      id: parseInt(pivot['id']),
      isolateNumber: parseString(pivot['isolate_number']),
      year: parseString(pivot['year']),
      percentage: parseString(pivot['percentage']),
      medicineId: parseInt(pivot['medicine_id']),
      medicineName: parseString(data['name']),
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
          'medicine_id': medicineId,
          'sample': sample,
          'reference_id': referenceId,
          'location': location,
        },
        'name': medicineName,
      };
}
