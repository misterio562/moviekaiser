import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:moviekaiser/domain/models/utiles.dart';

class RequestFavorite{
  static Future<bool> getFavoriteMovie(int idUser, int idMovie) async {
    var url = Uri.parse(
        "https://moviekaiser.online/APIFAVORITE/getFavoriteMovie.php?idUser=$idUser&idMovie=$idMovie");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  static Future<List<Mensajes>> addToFavoriteMovies(int iu, int im) async {
    var url = Uri.parse("https://moviekaiser.online/APIFAVORITE/addToFavoriteMovies.php");
    try {
      final response = await http
          .post(url, body: {"idUser": iu.toString(), "idMovie": im.toString()});
      return compute(convertirAlista2, response.body);
    } catch (error) {
      return compute(convertirAlista2, error.toString());
    }
  }
  static Future<bool> deleteFavoriteMovie(int idUser, int idMovie) async {
    var url = Uri.parse(
        "https://moviekaiser.online/APIFAVORITE/deleteFavoriteMovie.php");
    try {
      final response = await http.post(url, body: {
        "idUser": idUser.toString(),
        "idMovie": idMovie.toString()
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
  static List<Mensajes> convertirAlista2(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(pasar);
    //print(pasar[0]['mensaje']);
    return pasar.map<Mensajes>((json) => Mensajes.desdeJson(json)).toList();
  }
}