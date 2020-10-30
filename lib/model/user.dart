class User {
  final int id;
  final String apiToken;
  final String firstName;
  final String lastName;
  final String location;
  final String email;
  final Map settings;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.location,
    this.email,
    this.settings,
    this.apiToken,
  });

  factory User.fromMap(Map data) {
    return User(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      location: data['location'],
      email: data['email'],
      settings: data['settings'],
      apiToken: data['api_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'settings': settings,
        'api_token': apiToken,
      };
}
