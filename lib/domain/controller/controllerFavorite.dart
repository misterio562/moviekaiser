import 'package:get/get.dart';
import 'package:moviekaiser/data/services/requestFavorite.dart';
import 'package:moviekaiser/domain/models/utiles.dart';

class ControlFavorite extends GetxController {
  final Rxn<List<Mensajes>> _listarMensajes = Rxn<List<Mensajes>>([]);

  Future<bool> getFavoriteMovie(idUser, int idMovie) async {
    return await RequestFavorite.getFavoriteMovie(idUser, idMovie);
  }

  Future<void> addToFavoriteMovies(int iu, int im) async {
    _listarMensajes.value = await RequestFavorite.addToFavoriteMovies(iu, im);
  }

  Future<bool> deleteFavoriteMovie(int idUser, int idMovie) async {
    return await RequestFavorite.deleteFavoriteMovie(idUser, idMovie);
  }
}
