import 'package:dio/dio.dart';

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
    final Response response = await getData('/movie/'+type, params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    }
    throw response;
  }
}
