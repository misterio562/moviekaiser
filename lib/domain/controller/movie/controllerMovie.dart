import 'package:get/get.dart';
import 'package:moviekaiser/data/services/requestMovie.dart';
import 'package:moviekaiser/domain/models/movie.dart';

class ControlMovie extends GetxController {
  final Rxn<List<Movie>> listPopularMovie = Rxn<List<Movie>>([]);
  final Rxn<List<Movie>> listTrendMovie = Rxn<List<Movie>>([]);

  Future<void> getPopularMovies() async {
    listPopularMovie.value = await RequestMovie.getPopularMovies();
  }

  Future<void> getTrendMovies() async {
    listTrendMovie.value = await RequestMovie.getTrendMovies();
  }

  Future<bool> addLike(int idMovie) async {
    return await RequestMovie.addLike(idMovie);
  }

  Future<bool> deleteLike(int idMovie) async {
    return await RequestMovie.deleteLike(idMovie);
  }

  List<Movie>? get listPopularMovieGral => listPopularMovie.value;
  List<Movie>? get listTrendMovieGral => listTrendMovie.value;
}
