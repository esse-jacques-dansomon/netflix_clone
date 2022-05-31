// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Video({
    required this.name,
    required this.key,
  });

  final String name;
  final String key;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    name: json["name"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
  };
}
