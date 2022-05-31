// To parse this JSON data, do
//
//     final imageGalerie = imageGalerieFromJson(jsonString);

import 'dart:convert';

ImageGalerie imageGalerieFromJson(String str) => ImageGalerie.fromJson(json.decode(str));

String imageGalerieToJson(ImageGalerie data) => json.encode(data.toJson());

List<ImageGalerie> imageGalerieListFromJson(dynamic str) => List<ImageGalerie>.from(json.decode(str).map((x) => ImageGalerie.fromJson(x)));

class ImageGalerie {
  ImageGalerie({
   required this.id,
    required this.image,
  });

  int id;
  String image;

  factory ImageGalerie.fromJson(Map<String, dynamic> json) => ImageGalerie(
    id: json["id"],
    image: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
