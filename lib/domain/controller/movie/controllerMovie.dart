import 'package:get/get.dart';
import 'package:moviekaiser/data/services/requestMovie.dart';
import 'package:moviekaiser/domain/models/movie.dart';

class ControlMovie extends GetxController{
  final Rxn<List<Movie>> listMovie = Rxn<List<Movie>>([]);
  final Rxn<int> likes = Rxn<int>();

  Future<void> getMovieGral() async{
    listMovie.value = await RequestMovie.getListMovie();
  }

  // Future<void> rated() async{
  //   likes.value = await RequestMovie.getLikesMovie();
  // }

  List<Movie>? get listMovieGral => listMovie.value;
  int? get likesGral => likes.value;

}