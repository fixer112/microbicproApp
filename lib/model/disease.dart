class Disease {
  final int id;
  final String name;
  final String overview;
  final String category;
  final String features;
  final String treatmentObjectives;
  final String location;

  Disease({
    this.category,
    this.features,
    this.treatmentObjectives,
    this.name,
    this.overview,
    this.id,
    this.location,
  });

  factory Disease.fromMap(Map data) {
    return Disease(
      id: data['id'],
      name: data['name'],
      overview: data['overview'],
      location: data['location'],
      category: data['category'],
      treatmentObjectives: data['treatment_objectives'],
      features: data['features'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'location': location,
        'features': features,
        'treatment_objectives': treatmentObjectives,
        'category': category,
      };
}
