import 'package:microbicpro/model/pathogen.dart';

class MedicineAntiBiogramData {
  final int id;
  final String isolateNumber;
  final String year;
  final String percentage;
  final int pathogenId;
  final String pathogenName;
  final String sample;

  MedicineAntiBiogramData({
    this.isolateNumber,
    this.percentage,
    this.year,
    this.pathogenId,
    this.pathogenName,
    this.id,
    this.sample,
  });

  factory MedicineAntiBiogramData.fromMap(Map data) {
    return MedicineAntiBiogramData(
      id: data['pivot']['id'],
      isolateNumber: data['pivot']['isolate_number'],
      year: data['pivot']['year'],
      percentage: data['pivot']['percentage'],
      pathogenId: int.parse(data['pivot']['pathogen_id']),
      pathogenName: data['name'],
      sample: data['pivot']['sample'],
    );
  }
  Map<String, dynamic> toJson() => {
        'pivot': {
          'id': id,
          'isolate_number': isolateNumber,
          'year': year,
          'percentage': percentage,
          'medicine_id': pathogenId,
          'sample': sample,
        },
        'name': pathogenName,
      };
}
