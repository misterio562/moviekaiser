import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/pages/homepages.dart';
import 'package:moviekaiser/ui/content/listaPelicula.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      initialRoute: '/home',
      routes: {
        "/home": (context)=> const Home(),
        "/listmovie": (context)=> const ListMovies()
      },
    );
  }
}