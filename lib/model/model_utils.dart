import 'dart:convert';

/// Parses [value] into an [int], falling back to [fallback] when parsing fails.
int parseInt(Object? value, {int fallback = 0}) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value == null) {
    return fallback;
  }
  return int.tryParse(value.toString()) ?? fallback;
}

/// Converts any object to a [String], returning [fallback] when the value is
/// `null`.
String parseString(Object? value, {String fallback = ''}) {
  if (value == null) {
    return fallback;
  }
  if (value is String) {
    return value;
  }
  return value.toString();
}

/// Normalizes different representations (JSON string, List, etc.) of a list of
/// maps into a strongly typed [List] of maps.
List<Map<String, dynamic>> mapList(Object? source) {
  final Iterable<dynamic> iterable;
  if (source is String) {
    final decoded = _tryDecodeJson(source);
    if (decoded is! Iterable) {
      return const <Map<String, dynamic>>[];
    }
    iterable = decoded;
  } else if (source is Iterable) {
    iterable = source;
  } else {
    return const <Map<String, dynamic>>[];
  }

  return iterable
      .where((element) => element is Map)
      .map((element) =>
          Map<String, dynamic>.from(element as Map<dynamic, dynamic>))
      .toList();
}

/// Builds a strongly-typed list of models by applying [builder] to every map
/// contained in [source].
List<T> buildModelList<T>(
  Object? source,
  T Function(Map<String, dynamic> data) builder,
) {
  return mapList(source).map(builder).toList();
}

Object? _tryDecodeJson(String source) {
  try {
    return jsonDecode(source);
  } catch (_) {
    return null;
  }
}
