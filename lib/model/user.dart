import 'model_utils.dart';

class User {
  final int id;
  final String apiToken;
  final String firstName;
  final String lastName;
  final String location;
  final String email;
  final Map<String, dynamic> settings;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.email,
    required this.settings,
    required this.apiToken,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    final rawSettings = data['settings'];
    return User(
      id: parseInt(data['id']),
      firstName: parseString(data['first_name']),
      lastName: parseString(data['last_name']),
      location: parseString(data['location']),
      email: parseString(data['email']),
      settings: rawSettings is Map
          ? Map<String, dynamic>.from(
              rawSettings,
            )
          : <String, dynamic>{},
      apiToken: parseString(data['api_token']),
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
