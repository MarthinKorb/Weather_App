import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherResponse2 {
  String message;
  String cod;
  int count;
  List<dynamic> list;
  WeatherResponse2({
    this.message,
    this.cod,
    this.count,
    this.list,
  });

  WeatherResponse2 copyWith({
    String message,
    String cod,
    int count,
    List<dynamic> list,
  }) {
    return WeatherResponse2(
      message: message ?? this.message,
      cod: cod ?? this.cod,
      count: count ?? this.count,
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'cod': cod,
      'count': count,
      'list': list,
    };
  }

  factory WeatherResponse2.fromMap(Map<String, dynamic> map) {
    return WeatherResponse2(
      message: map['message'],
      cod: map['cod'],
      count: map['count'],
      list: List<dynamic>.from(map['list']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherResponse2.fromJson(String source) =>
      WeatherResponse2.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherResponse2(message: $message, cod: $cod, count: $count, list: $list)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherResponse2 &&
        other.message == message &&
        other.cod == cod &&
        other.count == count &&
        listEquals(other.list, list);
  }

  @override
  int get hashCode {
    return message.hashCode ^ cod.hashCode ^ count.hashCode ^ list.hashCode;
  }
}
