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
  final int alternative;
  final int medicineId;

  DrugManagement({
    this.id,
    this.diseaseId,
    this.type,
    this.category,
    this.stage,
    this.strength,
    this.interval,
    this.duration,
    this.root,
    this.cLass,
    this.alternative,
    this.medicineId,
  });

  factory DrugManagement.fromMap(Map data) {
    return DrugManagement(
      diseaseId: int.parse(data['disease_id'].toString()),
      type: data['type'] ?? '',
      stage: data['stage'] ?? '',
      strength: data['strength'] ?? '',
      interval: data['interval'] ?? '',
      duration: data['duration'] ?? '',
      root: data['root'] ?? '',
      cLass: data['class'] ?? '',
      alternative: data['alternative'] ?? '',
      medicineId: int.parse(data['medicine_id'].toString()),
      id: int.parse(data['id'].toString()),
      category: data['category'] ?? '',
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
      };
}
