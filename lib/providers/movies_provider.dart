import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_requests/models/app_models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = dotenv.env['API_KEY'] ?? '';
  String _language = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  // Map the movie id to the cast
  // So that we can load the cast quickly if it's in memory
  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    print('MoviesProvider initialized');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    // print(response.body);
    return response.body;
  }

  getOnDisplayMovies() async {
    // print(response.body);
    final jsonData = await this._getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);

    onDisplayMovies = nowPlayingResponse.movies;

    // Tell listening widgets to rebuild
    notifyListeners();
  }

  getPopularMovies() async {
    final jsonData = await _getJsonData('/3/movie/popular');
    final popularMoviesResponse = PopularResponse.fromRawJson(jsonData);

    popularMovies = popularMoviesResponse.movies;

    // Tell listening widgets to rebuild
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    // print("Getting server info for cast");

    final jsonData = await _getJsonData('/3/movie/$movieId/credits');
    // print('JSON Data: $jsonData');
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);
    // print(creditsResponse);

    moviesCast[movieId] = creditsResponse.cast;
    // print(moviesCast[movieId]!);

    return creditsResponse.cast;
  }
}
