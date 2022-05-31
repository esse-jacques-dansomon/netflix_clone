import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/Image.dart';
import 'package:netflix_clone/services/api_service.dart';

import '../models/Acteur.dart';
import '../models/DetailsMovie.dart';
import '../models/movie.dart';
import '../models/video.dart';

class DataRepository with ChangeNotifier{
  final ApiService apiService = ApiService();
  int pageNumber = 1;
  int pageNumberNw = 1;
  int pageNumberCm= 1;
  int pageNumberTr= 1;

  final List<Movie> _popularMovies = [];
  final List<Movie> _nowPlayings = [];
  final List<Movie> _comingSoon = [];
  final List<Movie> _topRated = [];
  final List<Acteur> _acteurs = [];
  List<Movie> get topRated => _topRated ;
  List<Movie> get comingSoon => _comingSoon ;
  List<Movie> get nowPlayings => _nowPlayings;
  List<Movie> get popularMovies => _popularMovies ;
  List<Acteur> get acteurs => _acteurs;

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


  Future<void> getNowPlayings() async {
    try {
      List<Movie> movies = await apiService.getMovies(pageNumber: pageNumberNw, type: 'now_playing');
      nowPlayings.addAll(movies);
      pageNumberNw++;
      notifyListeners();
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }


  Future<void> getComingSoons() async {
    try {
      List<Movie> movies = await apiService.getMovies(pageNumber: pageNumberCm, type: 'upcoming');
      comingSoon.addAll(movies);
      pageNumberCm++;
      notifyListeners();
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }

  Future<void> getTopRated() async {
    try {
      List<Movie> movies = await apiService.getMovies(pageNumber: pageNumberTr, type: 'top_rated');
      topRated.addAll(movies);
      pageNumberTr++;
      notifyListeners();
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }

  Future<DetailsMovie> getDetailsMovie({required int movieId}) async {
    try {
      final DetailsMovie detailsMovie = await apiService.getDetailsMovie(movieId: movieId);
      return detailsMovie;
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');

      rethrow;
    }
  }


  Future<List<Acteur>> getActeursByMovie({required int movieId}) async {
    try {
      final List<Acteur> acteurs = await apiService.getActeursByMovie(movieId: movieId);
      return acteurs;
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }

  Future<List<Video>> getVideosByMovie({required int movieId}) async {
    try {
      final List<Video> videos = await apiService.getVideosByMovie(movieId: movieId);
      return videos;
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }


  Future<List<ImageGalerie>> getImagesByMovie({required int movieId}) async {
    try {
      final List<ImageGalerie> images = await apiService.getGalerie(movieId: movieId);
      return images;
    }on Response catch(re){
      print('Erreur, ${re.statusCode}');
      rethrow;
    }
  }

  Future<void> initData() async{
    await getPopularMovie();
    await getNowPlayings();
    await getComingSoons();
    await getTopRated();

  }



}