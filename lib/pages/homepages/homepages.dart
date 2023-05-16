import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/ui/auth/login.dart';

import '../../domain/models/movie.dart';
import '../../ui/content/videoPlayer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ControlMovie controlm = Get.find();
  ControlUser controlu = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controlm.getMovieGral();
    super.initState();
  }

  void _signOut() async {
    ControlUser controlu = Get.find<ControlUser>();
    controlu.listaUserLogin = []; // Asignar una lista vacía a listaUserLogin
    //Lo hacemos así para no complicarnos la vida, se le pasa un array vació a los datos del usuario
    //Es como si no hubiera nadie logeado

    Get.offAll(const Login()); // Navegar a la página de inicio de sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 40,
          width: 40,
          child: Image.asset('assets/logoMoviekaiser.png'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons
                .account_circle_outlined), // Aquí puedes cambiar el icono por el que desees
            onPressed: () {
              // Aquí puedes definir la acción al presionar el icono
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
        backgroundColor: Colors.amber,
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black87,
        width: 200,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: Center(
                  child: Image.asset(
                'assets/logoMoviekaiser.png',
                fit: BoxFit.cover,
              )),
            ),
            ListTile(
              title: Text("Nombre:\n${controlu.listaUserLogin?[0].nombre}",
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text("Correo:\n${controlu.listaUserLogin?[0].user}",
                  style: const TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.logout,
                  color: Color.fromARGB(255, 255, 255, 255)),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.white),
              ),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: const BodyHome(),
      bottomNavigationBar: const BottonNavigatosBar(),
      backgroundColor: Colors.black,
    );
  }
}

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  @override
  Widget build(BuildContext context) {
    final ControlMovie controlm = Get.find();
    print(controlm.listMovieGral!.length);
    controlm.getMovieGral().then((value) => Get.toNamed('/home'));

    // ignore: no_leading_underscores_for_local_identifiers
    void _onTap(int index) {
      Movie movie = controlm.listMovieGral![index];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoDemo(movie: movie)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Populares en Movikaiser',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150, // Altura de la lista de imágenes
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Desplazamiento horizontal
                    itemCount: controlm.listMovieGral!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final movie = controlm.listMovieGral![index];
                      // Aquí debes definir cómo se muestra cada imagen en la lista
                      try {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            //child: Image.network("https://cdn.pixabay.com/photo/2019/10/17/21/17/joker-4557864_960_720.jpg"),
                            child: InkWell(
                              onTap: () {
                                _onTap(index);
                              },
                              child: Image.network(
                                movie.image,
                                height: 120,
                              ),
                            ));
                      } catch (e) {
                        print('Error al cargar la imagen: $e');
                        return const SizedBox(); // O muestra un widget alternativo en caso de error
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Tendencias',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sugeridos para ti',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
          ),
          FloatingActionButton(onPressed: () {
            controlm.getMovieGral().then((value) => Get.toNamed('/listmovie'));
          })
        ],
      ),
    );
  }
}

// class name extends StatelessWidget {
//   const name({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ControlMovie controlm = Get.find();
//     final List<String> buttonNames = [
//       'Animado',
//       'Suspenso',
//       'Terror',
//       'Acción',
//       'Comedia',
//       'Ficción'
//     ];

//     return Container(
//         padding: const EdgeInsets.all(50),
//         child: GridView.count(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 2,
//           children: List.generate(buttonNames.length, (index) {
//             // Escoge un color aleatorio para cada botón
//             final color = Colors.primaries[index % Colors.primaries.length];
//             return ElevatedButton(
//               onPressed: () {
//                 controlm
//                     .getMovieGral()
//                     .then((value) => Get.toNamed('/listmovie'));
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: color,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//               ),
//               child: Text(
//                 buttonNames[index],
//                 style: const TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             );
//           }),
//         ));
//   }
// }

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
