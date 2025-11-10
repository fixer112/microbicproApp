import 'model_utils.dart';

class DrugManagement {
  final int id;
  final int diseaseId;
  final String type;
  final String category;
  final String stage;
  final String strength;
  final String interval;
  final String duration;
  final String root;
  final String cLass;
  final int? alternative;
  final int medicineId;
  final String medicineName;

  const DrugManagement({
    required this.id,
    required this.diseaseId,
    required this.type,
    required this.category,
    required this.stage,
    required this.strength,
    required this.interval,
    required this.duration,
    required this.root,
    required this.cLass,
    required this.medicineId,
    required this.medicineName,
    this.alternative,
  });

  factory DrugManagement.fromMap(Map<String, dynamic> data) {
    return DrugManagement(
      diseaseId: parseInt(data['disease_id']),
      type: parseString(data['type']),
      stage: parseString(data['stage']),
      strength: parseString(data['strength']),
      interval: parseString(data['interval']),
      duration: parseString(data['duration']),
      root: parseString(data['root']),
      cLass: parseString(data['class']),
      alternative:
          data['alternative'] == null ? null : parseInt(data['alternative']),
      medicineId: parseInt(data['medicine_id']),
      id: parseInt(data['id']),
      category: parseString(data['category']),
      medicineName: parseString(data['medicine_name']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'stage': stage,
        'strength': strength,
        'interval': interval,
        'duration': duration,
        'category': category,
        'root': root,
        'class': cLass,
        'disease_id': diseaseId,
        'medicine_id': medicineId,
        'alternative': alternative,
        'medicine_name': medicineName,
      };
}
