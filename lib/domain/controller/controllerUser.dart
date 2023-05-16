import 'package:get/get.dart';
import '../../data/services/requestUser.dart';
import '../models/user.dart';
import '../models/utiles.dart';

class ControlUser extends GetxController {
  final Rxn<List<Mensajes>> _listarMensajes = Rxn<List<Mensajes>>([]);
  final Rxn<List<User>> _listarUser = Rxn<List<User>>([]);

  Future<void> crearUser(String nombre, String u, String p) async {
    _listarMensajes.value = await PeticionesUser.registrarUser(nombre, u, p);
  }

  Future<void> validarUser(String u, String p) async {
    _listarUser.value = await PeticionesUser.validarUser(u, p);
  }

  List<Mensajes>? get listaMensajes => _listarMensajes.value;
  List<User>? get listaUserLogin => _listarUser.value;
  set listaUserLogin(List<User>? value) => _listarUser.value = value;
}
