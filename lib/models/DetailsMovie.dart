// To parse this JSON data, do
//
//     final DetailsMovie = DetailsMovieFromJson(jsonString);

import 'dart:convert';

DetailsMovie DetailsMovieFromJson(String str) => DetailsMovie.fromJson(json.decode(str));

String DetailsMovieToJson(DetailsMovie data) => json.encode(data.toJson());

class DetailsMovie {
  DetailsMovie({
    required this.id,
    required this.releaseDate,
    required this.voteAverage,
  });

  int id;
  DateTime releaseDate;
  double voteAverage;

  factory DetailsMovie.fromJson(Map<String, dynamic> json) => DetailsMovie(
    id: json["id"],
    releaseDate: DateTime.parse(json["release_date"]),
    voteAverage: json["vote_average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "vote_average": voteAverage,
  };
}
