import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logoApp.png'),
        backgroundColor: Colors.amber,
      ),
      body: const name(),
      bottomNavigationBar: const BottonNavigatosBar(),
      backgroundColor: Colors.black,
    );
  }
}

class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    ControlMovie controlm = Get.find();
    final List<String> buttonNames = [
      'Animado',
      'Suspenso',
      'Terror',
      'Acción',
      'Comedia',
      'Ficción'
    ];

    return Container(
        padding: const EdgeInsets.all(50),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2,
          children: List.generate(buttonNames.length, (index) {
            // Escoge un color aleatorio para cada botón
            final color = Colors.primaries[index % Colors.primaries.length];
            return ElevatedButton(
              onPressed: () {
                controlm
                    .getMovieGral()
                    .then((value) => Get.toNamed('/listmovie'));
              },
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                buttonNames[index],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }),
        ));
  }
}

class BottonNavigatosBar extends StatefulWidget {
  const BottonNavigatosBar({super.key});

  @override
  State<BottonNavigatosBar> createState() => _BottonNavigatosBarState();
}

class _BottonNavigatosBarState extends State<BottonNavigatosBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(30)),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        ],
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
