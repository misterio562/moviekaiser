import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:moviekaiser/domain/models/liked.dart';
import 'package:http/http.dart' as http;
import 'package:moviekaiser/domain/models/utiles.dart';

class RequestLiked {
  static Future<List<Liked>> getLiked() async {
    var url = Uri.parse("https://moviekaiser.online/APILIKED/listLiked.php");
    final response = await http.get(url);

    return compute(convertirAlista, response.body);
  }
  static List<Liked> convertirAlista(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(pasar);
    //print(pasar[0]['mensaje']);
    return pasar.map<Liked>((json) => Liked.desdeJson(json)).toList();
  }

  static Future<List<Mensajes>> addLike(int iu, int im) async {
    var url = Uri.parse("https://moviekaiser.online/APILIKED/addLike.php");
    try {
      final response = await http
          .post(url, body: {"idUser": iu.toString(), "idMovie": im.toString()});
      return compute(convertirAlista2, response.body);
    } catch (error) {
      return compute(convertirAlista2, error.toString());
    }
  }
  static List<Mensajes> convertirAlista2(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(pasar);
    //print(pasar[0]['mensaje']);
    return pasar.map<Mensajes>((json) => Mensajes.desdeJson(json)).toList();
  }

  static Future<bool> getLikedByIdUser(int idUser, int idMovie) async {
    var url = Uri.parse(
        "https://moviekaiser.online/APILIKED/getLikedByIdUser.php?idUser=$idUser&idMovie=$idMovie");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteLike(int idUser, int idMovie) async {
    var url = Uri.parse(
        "https://moviekaiser.online/APILIKED/deleteLike.php");
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

  
}
