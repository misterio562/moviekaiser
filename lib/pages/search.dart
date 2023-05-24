import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/domain/models/movie.dart';
import 'package:moviekaiser/ui/content/videoPlayer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late ControlMovie controlm;
  late List<Movie> searchResults = [];

  @override
  void initState() {
    super.initState();
    controlm = Get.find<ControlMovie>();
    loadAllMovies();
  }

  void loadAllMovies() {
  setState(() {
    searchResults = controlm.listPopularMovieGral!;
  });
}


  void onTapPopular(int index) {
    Movie movie = controlm.listPopularMovieGral![index];
    Get.to(() => VideoDemo(movie: movie));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    // Mostrar todas las películas si el campo de texto está vacío
                    searchResults = controlm.listPopularMovieGral!;
                  } else {
                    // Filtrar la lista de películas según el texto de búsqueda
                    searchResults = controlm.listPopularMovieGral!
                        .where((movie) => movie.title
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Buscar pelicula',
                  border: InputBorder.none,
                  icon: Icon(Icons.search)),
            ),
          ),
          body: GridView.count(
            crossAxisCount: 3,
            children:
                List.generate(searchResults.length, (index) {
              final movie = searchResults[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => onTapPopular(index),
                  child: Image.network(movie.image),
                ),
              );
            }),
          ),
        ));
  }
}
