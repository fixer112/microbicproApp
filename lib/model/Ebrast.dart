import 'model_utils.dart';

class Ebrast {
  final int id;
  final String sample;
  final String diseases;
  final List<Map<String, dynamic>> medicines;
  final String location;

  const Ebrast({
    required this.id,
    required this.sample,
    required this.diseases,
    required this.medicines,
    required this.location,
  });

  factory Ebrast.fromMap(Map<String, dynamic> data) {
    return Ebrast(
      id: parseInt(data['id']),
      diseases: parseString(data['diseases']),
      medicines: mapList(data['medicines']),
      location: parseString(data['location']),
      sample: parseString(data['sample']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
        'diseases': diseases,
        'sample': sample,
        'medicines': medicines,
      };
}
