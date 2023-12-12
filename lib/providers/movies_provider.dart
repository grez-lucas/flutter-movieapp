import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_requests/models/app_models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '2d5f7b977fb4f2724eea533644779983';
  String _language = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider initialized');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    // print(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    onDisplayMovies = nowPlayingResponse.movies;

    // Tell listening widgets to rebuild
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    print(response.body);
    final popularMoviesResponse = PopularResponse.fromRawJson(response.body);

    popularMovies = popularMoviesResponse.movies;

    // Tell listening widgets to rebuild
    notifyListeners();
  }
}
