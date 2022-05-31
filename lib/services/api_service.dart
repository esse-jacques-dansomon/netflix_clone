import 'package:dio/dio.dart';
import 'package:netflix_clone/models/DetailsMovie.dart';
import 'package:netflix_clone/models/Image.dart';
import 'package:netflix_clone/models/video.dart';

import '../models/Acteur.dart';
import '../models/movie.dart';
import 'api.dart';

class ApiService {
  final Api api = Api();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
   
    String url = api.baseUrl + path;
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    if (params != null) {
      query.addAll(params);
    }
   

    final Response response = await dio.get(url, queryParameters: query);

    if (response.statusCode == 200) {
      return response;
    }
    throw response;
  }

  
  Future<List<Movie>> getMovies({required int pageNumber, required String type}) async {
    final Response response = await getData('/movie/$type', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    }
    throw response;
  }

  Future<DetailsMovie> getDetailsMovie({required int movieId}) async {
    final Response response = await getData('/movie/$movieId');
    if (response.statusCode == 200) {
      final dynamic results = response.data;
      return DetailsMovie.fromJson(results);
    }
    throw response;
  }

  Future<List<Acteur>> getActeursByMovie({required int movieId}) async {
    final Response response = await getData(
        '/movie/$movieId/credits');
    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['cast'];

      List<Acteur> acteurs = [];
      for (var i = 0; i < results.length; i++) {
        var img = results[i]['profile_path'] != null
            ? api.baseImageUrl + results[i]['profile_path']
            : 'https://via.placeholder.com/500?text=No+Image';
        acteurs.add(Acteur(
          id: results[i]['id'],
          name: results[i]['name'],
           character: results[i]['character'],
          profilePath: img,

        ));
      }
      return acteurs ;
    }
    throw response;
  }

  Future<List<Video>> getVideosByMovie({required int movieId}) async {
    final Response response = await getData(
        '/movie/$movieId/videos');
    if (response.statusCode == 200) {
      print(response.data);
      final List<dynamic> results = response.data['results'];
      List<Video> videos = [];
      for (var i = 0; i < results.length; i++) {
        videos.add(Video(
          name: results[i]['name'],
           key: results[i]['key'],
        ));
      }
      return videos ;
    }
    throw response;
  }


  Future<List<ImageGalerie>> getGalerie({required int movieId}) async {
    final Response response = await getData('/movie/$movieId/images');

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['posters'];
      print(response.data);
      List<ImageGalerie> images = [];
      for (var i = 0; i < results.length; i++) {
        var img = results[i]['file_path'] != null
            ? api.baseImageUrl + results[i]['file_path']
            : 'https://via.placeholder.com/500?text=No+Image';
      }
      return  images;
    }
    throw response;
  }





}
