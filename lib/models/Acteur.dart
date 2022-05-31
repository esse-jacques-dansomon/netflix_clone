// To parse this JSON data, do
//
//     final acteur = acteurFromJson(jsonString);

import 'dart:convert';

import '../services/api.dart';

Acteur acteurFromJson(String str) => Acteur.fromJson(json.decode(str));

String acteurToJson(Acteur data) => json.encode(data.toJson());
List<Acteur> ActeurListFromJson(String str) => List<Acteur>.from(json.decode(str).map((x) => Acteur.fromJson(x)));

class Acteur {
  Api api = Api();

  Acteur({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  int id;
  String name;
  String character;
  String profilePath;

  factory Acteur.fromJson(Map<String, dynamic> json) => Acteur(
    id: json["id"],
    name: json["name"],
    character: json["character"],
    profilePath:  json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "character": character,
    "profile_path": profilePath,
  };

  String acteurProfileUrl() {
    Api api = Api();
    //print(api.baseImageUrl + posterPath!);
    return api.baseImageUrl + profilePath;
  }
}
