import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/model/user.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:microbicpro/pages/home.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

const Map<String, String> _jsonHeaders = {'Accept': 'application/json'};

Future<List<Pathogen>> getPathogens(BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/pathogens'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final pathogens = _asMapList(body).map(Pathogen.fromMap).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    main.setPathogens(pathogens);
    await saveJson(jsonEncode(pathogens), fileName: 'pathogens.json');
    return pathogens;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getPathogens', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return main.getPathogens;
}

Future<Pathogen?> getPathogen(int id, BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/pathogens/$id'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final pathogen = Pathogen.fromMap(_asMap(body));
    final updated =
        _upsert(main.getPathogens, (item) => item.id == id, pathogen);
    main.setPathogens(updated);
    await saveJson(jsonEncode(updated), fileName: 'pathogens.json');
    return pathogen;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getPathogen', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return null;
}

Future<List<Medicine>> getMedicines(BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/medicines'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final medicines = _asMapList(body).map(Medicine.fromMap).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    main.setMedicines(medicines);
    await saveJson(jsonEncode(medicines), fileName: 'medicines.json');
    return medicines;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getMedicines', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return main.getMedicines;
}

Future<Medicine?> getMedicine(int id, BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/medicines/$id'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final medicine = Medicine.fromMap(_asMap(body));
    final updated =
        _upsert(main.getMedicines, (item) => item.id == id, medicine);
    main.setMedicines(updated);
    await saveJson(jsonEncode(updated), fileName: 'medicines.json');
    return medicine;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getMedicine', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return null;
}

Future<List<Disease>> getDiseases(BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/diseases'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final diseases = _asMapList(body).map(Disease.fromMap).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    main.setDiseases(diseases);
    await saveJson(jsonEncode(diseases), fileName: 'diseases.json');
    return diseases;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getDiseases', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return main.getDiseases;
}

Future<Disease?> getDisease(int id, BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/diseases/$id'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final disease = Disease.fromMap(_asMap(body));
    final updated = _upsert(main.getDiseases, (item) => item.id == id, disease);
    main.setDiseases(updated);
    await saveJson(jsonEncode(updated), fileName: 'diseases.json');
    return disease;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getDisease', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return null;
}

Future<List<Ebrast>> getEbrasts(BuildContext context,
    {String? location}) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final uri = location == null
        ? Uri.parse('$url/api/ebrasts')
        : Uri.parse('$url/api/ebrasts/?location=$location');
    final response = await http.get(uri, headers: _jsonHeaders);
    final body = _decodeBody(response);
    final ebrasts = _asMapList(body).map(Ebrast.fromMap).toList()
      ..sort((a, b) => a.location.compareTo(b.location));
    await saveJson(jsonEncode(ebrasts), fileName: 'ebrasts.json');
    main.setEbrasts(ebrasts);
    return ebrasts;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getEbrasts', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return main.getEbrasts;
}

Future<Ebrast?> getEbrast(int id, BuildContext context) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.get(
      Uri.parse('$url/api/ebrasts/$id'),
      headers: _jsonHeaders,
    );
    final body = _decodeBody(response);
    final ebrast = Ebrast.fromMap(_asMap(body));
    final updated = _upsert(main.getEbrasts, (item) => item.id == id, ebrast);
    await saveJson(jsonEncode(updated), fileName: 'ebrasts.json');
    main.setEbrasts(updated);
    return ebrast;
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('getEbrast', e, stack);
    Widgets.snackbar('An error occurred');
  }
  return null;
}

Future<void> login(
  Map<String, dynamic> data,
  BuildContext context, {
  bool refresh = false,
}) async {
  final main = Provider.of<MainModel>(context, listen: false);
  try {
    final response = await http.post(
      Uri.parse('$url/api/login'),
      body: data,
      headers: _jsonHeaders,
    );

    await request(response, (body) async {
      final user = User.fromMap(_asMap(body));
      main.setUser(user);
      await saveJson(jsonEncode(data));
      await saveJson(jsonEncode(user), fileName: 'users.json');
      if (!refresh) Get.off(() => Home());
    }, context);
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('login', e, stack);
    Widgets.snackbar('An error occurred');
  }
}

Future<void> register(Map<String, dynamic> data, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('$url/api/register'),
      body: data,
      headers: _jsonHeaders,
    );

    await request(response, (body) async {
      final main = Provider.of<MainModel>(context, listen: false);
      main.setUser(User.fromMap(_asMap(body)));
      await saveJson(jsonEncode(data));
      await login(data, context);
    }, context);
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('register', e, stack);
    Widgets.snackbar('An error occurred');
  }
}

Future<void> changeLocation(String? location, BuildContext context) async {
  if (location == null) {
    return;
  }
  final main = Provider.of<MainModel>(context, listen: false);
  final user = main.getUser;
  if (user == null) {
    Widgets.snackbar('Please log in again');
    return;
  }
  try {
    final uri = Uri.parse(
        '$url/api/user/${user.id}/location?api_token=${user.apiToken}');
    final response = await http.post(
      uri,
      body: {'location': location},
      headers: _jsonHeaders,
    );

    await request(response, (_) async {
      Widgets.snackbar('Location changed');
    }, context);
  } on SocketException {
    Widgets.snackbar('Please connect to the internet');
  } catch (e, stack) {
    _logError('changeLocation', e, stack);
    Widgets.snackbar('An error occurred');
  }
}

Future<void> request(
  http.Response response,
  Future<void> Function(dynamic body) action,
  BuildContext context,
) async {
  final body = _decodeBody(response);
  await processResponse(response.statusCode, body, action, context);
}

Future<void> processResponse(
  int statusCode,
  dynamic body,
  Future<void> Function(dynamic body) action,
  BuildContext context,
) async {
  if (statusCode == 401) {
    Widgets.snackbar('Please re-login');
    Get.off(() => Login());
    return;
  }

  if (statusCode == 422 && body is Map<String, dynamic>) {
    final errors = StringBuffer();
    final mapErrors = body['errors'];
    if (mapErrors is Map) {
      mapErrors.forEach((_, data) {
        if (data is List && data.isNotEmpty) {
          errors.writeln(data.first);
        }
      });
    }
    Widgets.snackbar(errors.isEmpty ? 'Validation error' : errors.toString());
    return;
  }

  if (statusCode >= 200 && statusCode < 300) {
    if (body is Map<String, dynamic>) {
      if (body.containsKey('error')) {
        Widgets.snackbar(body['error'].toString());
        return;
      }
      if (body.containsKey('success')) {
        Widgets.snackbar(body['success'].toString());
        return;
      }
    }
    await action(body);
  } else {
    Widgets.snackbar('An error occurred, please try later.');
  }
}

dynamic _decodeBody(http.Response response) {
  try {
    final body = json.decode(response.body);
    _logResponse(response, body);
    return body;
  } catch (e, stack) {
    _logError('decodeBody', e, stack);
    return null;
  }
}

void _logResponse(http.Response response, dynamic body) {
  if (kDebugMode) {
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: $body');
  }
}

void _logError(String label, Object error, StackTrace stackTrace) {
  if (kDebugMode) {
    debugPrint('$label error: $error');
    debugPrint(stackTrace.toString());
  }
}

Map<String, dynamic> _asMap(dynamic source) {
  if (source is Map) {
    return Map<String, dynamic>.from(source);
  }
  return <String, dynamic>{};
}

List<Map<String, dynamic>> _asMapList(dynamic source) {
  if (source is Iterable) {
    return source
        .where((element) => element is Map)
        .map((element) => Map<String, dynamic>.from(element as Map))
        .toList();
  }
  return <Map<String, dynamic>>[];
}

List<T> _upsert<T>(
  List<T> items,
  bool Function(T element) predicate,
  T newItem,
) {
  final updated = List<T>.from(items);
  final index = updated.indexWhere(predicate);
  if (index != -1) {
    updated[index] = newItem;
  } else {
    updated.add(newItem);
  }
  return updated;
}
