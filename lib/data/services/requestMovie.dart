import 'dart:convert'; //Necesario para json.decode
import 'package:flutter/foundation.dart'; //Necesario para compute
import 'package:moviekaiser/domain/models/movie.dart';
import 'package:http/http.dart' as http;

class RequestMovie{
  static Future<List<Movie>> getListMovie() async{
    var url = Uri.parse("https://busetp.000webhostapp.com/APIMOVIE/listaMovie.php");
    final response = await http.get(url);

    return compute(convertirAlista, response.body);
  }
  static List<Movie> convertirAlista(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(pasar);
    //print(pasar[0]['mensaje']);
    return pasar.map<Movie>((json) => Movie.desdeJson(json)).toList();
  }

  static Future<List<Movie>> getMovieByidGender()async{
    var url = Uri.parse("https://busetp.000webhostapp.com/APIMOVIE/listaMovieByIdGender.php");
    final response = await http.get(url);

    return compute(convertirAlistaByIdGender, response.body);
  }
  static List<Movie> convertirAlistaByIdGender(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(pasar);
    //print(pasar[0]['mensaje']);
    return pasar.map<Movie>((json) => Movie.desdeJson(json)).toList();
  }

  // static Future<int> getLikesMovie()async{
    
  // }

}