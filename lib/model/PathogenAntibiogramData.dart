import 'package:microbicpro/model/medicine.dart';

class PathogenAntibiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int medicineId;
  final String medicineName;
  final String sample;
  final int referenceID;
  final String location;

  PathogenAntibiogramData({
    this.isolateNumber,
    this.medicineId,
    this.percentage,
    this.year,
    this.id,
    this.medicineName,
    this.sample,
    this.referenceID,
    this.location,
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
        referenceID: data['pivot']['reference_id'],
        location: data['pivot']['location']);
  }
  Map<String, dynamic> toJson() => {
        'pivot': {
          'id': id,
          'isolate_number': isolateNumber,
          'year': year,
          'percentage': percentage,
          'medicine_id': medicineId,
          'sample': sample,
          'reference_id': referenceID,
          'location': location,
        },
        'name': medicineName,
      };
}
