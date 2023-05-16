import 'package:flutter/material.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/ui/content/videoPlayer.dart';

import '../../domain/models/movie.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  ControlMovie controlm = Get.find();

  @override
  void initState() {
    controlm.getMovieGral();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ControlMovie controlm = Get.find();
    print(controlm.listMovieGral!.length);

    void _onItemTap(int index) {
      Movie movie = controlm.listMovieGral![index];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoDemo(movie: movie,)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Lista de Peliculas'),
      ),
      body: ListView.builder(
          itemCount: controlm.listMovieGral!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(controlm.listMovieGral![index].image,
                    width: 200, height: 200),
              ),
              title: Text(controlm.listMovieGral![index].title,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                _onItemTap(index);
              },
            );
          }),
    );
  }
}
