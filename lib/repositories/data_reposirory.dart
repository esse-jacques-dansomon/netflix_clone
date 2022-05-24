import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/services/api_service.dart';

import '../models/movie.dart';

class DataRepository with ChangeNotifier{
  final ApiService apiService = ApiService();
  int pageNumber = 1;
  final List<Movie> _popularMovies = [];
  List<Movie> get popularMovies => _popularMovies ;

  Future<void> getPopularMovie() async {
    try {
      List<Movie> movies = await apiService.getMovies(pageNumber: pageNumber, type: 'popular');
      popularMovies.addAll(movies);
      pageNumber++;
      notifyListeners();
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }

  Future<void> initData() async{
    await getPopularMovie();
  }



}