import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/pages/homepages/homepages.dart';
import 'package:moviekaiser/ui/auth/login.dart';
import 'package:moviekaiser/ui/auth/register.dart';
import 'package:moviekaiser/ui/content/listaPelicula.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: '/login',
      routes: {
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/home": (context) => const Home(),
        "/listmovie": (context) => const ListMovies(),
      },
    );
  }
}
