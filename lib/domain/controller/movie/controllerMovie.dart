import 'package:get/get.dart';
import 'package:moviekaiser/data/services/requestMovie.dart';
import 'package:moviekaiser/domain/models/movie.dart';

class ControlMovie extends GetxController{
  final Rxn<List<Movie>> listMovie = Rxn<List<Movie>>([]);

  Future<void> getMovieGral() async{
    listMovie.value = await RequestMovie.getListMovie();
  }

  List<Movie>? get listMovieGral => listMovie.value;

}