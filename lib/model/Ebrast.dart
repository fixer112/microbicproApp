class Ebrast {
  final int id;
  final String sample;
  final String diseases;
  final List medicines;
  final String location;

  Ebrast({
    this.id,
    this.sample,
    this.diseases,
    this.medicines,
    this.location,
  });

  factory Ebrast.fromMap(Map data) {
    return Ebrast(
      id: data['id'],
      diseases: data['diseases'] ?? '',
      medicines: data['medicines'] ?? [],
      location: data['location'] ?? '',
      sample: data['sample'] ?? '',
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
