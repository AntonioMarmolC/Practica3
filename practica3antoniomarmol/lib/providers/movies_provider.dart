import 'package:flutter/widgets.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie_popular.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '2c80801dddfbe87a3297a37a9135d3d3';
  String _lenguage = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> onDisplayPopular = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies Provider inicialitzat!');
    this.getOnDisplayMovies();
    this.getOnPopularsMovies();
  }

  getOnDisplayMovies() async {
    // url con todo por partes
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _lenguage, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnPopularsMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _lenguage, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url); // json
    final PopularResponse = movies_popular.fromJson(result
        .body); // le decimos que la parte del body de resulta la pasemos a movies_popular
    onDisplayPopular = PopularResponse.results;
    // llama todos los registros listeners
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('Demanam info al servidor');

    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _lenguage, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
