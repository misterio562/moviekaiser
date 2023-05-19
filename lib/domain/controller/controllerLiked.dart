import 'package:get/get.dart';
import 'package:moviekaiser/data/services/requestLiked.dart';
import 'package:moviekaiser/domain/models/liked.dart';
import 'package:moviekaiser/domain/models/utiles.dart';

class ControlLiked extends GetxController {
  final Rxn<List<Liked>> _listarLiked = Rxn<List<Liked>>([]);
  final Rxn<List<Mensajes>> _listarMensajes = Rxn<List<Mensajes>>([]);

  Future<void> getLiked() async {
    _listarLiked.value = await RequestLiked.getLiked();
  }

  Future<void> addLike(int iu, int im) async {
    _listarMensajes.value = await RequestLiked.addLike(iu, im);
  }

  Future<bool> getLikedByIdUser(int idUser, int idMovie) async {
    return await RequestLiked.getLikedByIdUser(idUser, idMovie);
  }

  Future<bool> deleteLike(int idUser, int idMovie) async {
    return await RequestLiked.deleteLike(idUser, idMovie);
  }

  List<Liked>? get listaLikedGral => _listarLiked.value;
  List<Mensajes>? get listaMensajes => _listarMensajes.value;
}
