import 'package:microbicpro/model/medicine.dart';

class PathogenAntibiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int medicineId;
  final String medicineName;
  final String sample;
  PathogenAntibiogramData({
    this.isolateNumber,
    this.medicineId,
    this.percentage,
    this.year,
    this.id,
    this.medicineName,
    this.sample,
  });

  factory PathogenAntibiogramData.fromMap(Map data) {
    return PathogenAntibiogramData(
      id: data['pivot']['id'],
      isolateNumber: data['pivot']['isolate_number'],
      year: data['pivot']['year'],
      percentage: data['pivot']['percentage'],
      medicineId: int.parse(data['pivot']['medicine_id']),
      medicineName: data['name'],
      sample: data['pivot']['sample'],
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
        },
        'name': medicineName,
      };
}
