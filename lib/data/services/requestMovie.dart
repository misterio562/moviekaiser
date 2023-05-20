import 'dart:convert'; //Necesario para json.decode
import 'package:flutter/foundation.dart'; //Necesario para compute
import 'package:moviekaiser/domain/models/movie.dart';
import 'package:http/http.dart' as http;

class RequestMovie {
  static Future<List<Movie>> getPopularMovies() async {
    var url =
        Uri.parse("https://moviekaiser.online/APIMOVIE/getPopularMovies.php");
    final response = await http.get(url);

    return compute(convertirAlista, response.body);
  }

  static Future<List<Movie>> getTrendMovies() async {
    var url =
        Uri.parse("https://moviekaiser.online/APIMOVIE/getTrendMovies.php");
    final response = await http.get(url);

    return compute(convertirAlista, response.body);
  }

  static Future<List<Movie>> getFavoritesMovies(int iu) async {
    var url =
        Uri.parse("https://moviekaiser.online/APIMOVIE/getFavoritesMovies.php");
    final response = await http.post(url,body: {'idUser': iu.toString()});

    return compute(convertirAlista, response.body);
  }

  static Future<bool> addLike(int idMovie) async {
    var url = Uri.parse("https://moviekaiser.online/APIMOVIE/addLike.php");

    try {
      final response =
          await http.post(url, body: {'idMovie': idMovie.toString()});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteLike(int idMovie) async {
    var url = Uri.parse("https://moviekaiser.online/APIMOVIE/deleteLike.php");

    try {
      final response =
          await http.post(url, body: {'idMovie': idMovie.toString()});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static List<Movie> convertirAlista(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    //print(pasar[0]['mensaje']);
    return pasar.map<Movie>((json) => Movie.desdeJson(json)).toList();
  }
}
