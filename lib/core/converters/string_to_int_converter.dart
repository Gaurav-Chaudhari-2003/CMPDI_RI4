import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

class StringToIntConverter implements JsonConverter<int, Object?> {
  const StringToIntConverter();

  @override
  int fromJson(Object? json) {
    log('StringToIntConverter received: $json, type: ${json.runtimeType}');

    if (json == null) {
      log('StringToIntConverter received null. Returning 0.');
      return 0;
    }

    if (json is int) {
      return json;
    }

    if (json is String) {
      if (json.isEmpty) {
        log('StringToIntConverter received an empty string. Returning 0.');
        return 0;
      }
      final parsed = int.tryParse(json);
      if (parsed != null) {
        return parsed;
      }
    }

    log('StringToIntConverter could not convert "$json". Returning 0.');
    return 0;
  }

  @override
  Object toJson(int object) {
    return object.toString();
  }
}
