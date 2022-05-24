import '../services/api.dart';

class Movie {
  final int id;
  final String title;
  final String description;
  final String? posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id']?.toInt() ?? '0',
        title: json['title'],
        description: json['overview'],
        posterPath: json['poster_path'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'poster_path': posterPath,
      };

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, description: $description, posterPath: $posterPath}';
  }

  String posterUrl() {
    Api api = Api();
    //print(api.baseImageUrl + posterPath!);
    return api.baseImageUrl + posterPath!;
  }
}
