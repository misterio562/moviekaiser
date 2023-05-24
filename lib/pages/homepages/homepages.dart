import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/pages/search.dart';
import 'package:moviekaiser/ui/auth/login.dart';

import '../../domain/models/movie.dart';
import '../../ui/content/videoPlayer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ControlUser controlu;
  late ControlMovie controlm;

  static const _kTabPages = <Widget>[
    BodyHome(),
    Search()
  ];

  static const _kTabs = <Tab>[
    Tab(
      icon: Icon(Icons.home_outlined),
      text: 'Inicio',
    ),
    Tab(
      icon: Icon(Icons.search),
      text: 'Buscar',
    )
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _kTabPages.length, vsync: this);

    controlm = Get.find<ControlMovie>();
    controlu = Get.find<ControlUser>();
    controlm.getFavoritesMovies(controlu.listaUserLogin![0].id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(30)),
          child: Material(
            color: Colors.amber,
            child: TabBar(
              tabs: _kTabs,
              controller: _tabController,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
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
    print(controlm.listPopularMovieGral!.length);
    print(controlm.listPopularMovieGral!.length);
    print(controlm.listFavoriteMovieGral!.length);
    // controlm.getMovieGral().then((value) => Get.toNamed('/home'));

    // ignore: no_leading_underscores_for_local_identifiers
    void onTapPopular(int index) {
      Movie movie = controlm.listPopularMovieGral![index];
      Get.to(() => VideoDemo(movie: movie));
    }

    void onTapTrend(int index) {
      Movie movie = controlm.listTrendMovieGral![index];
      Get.to(() => VideoDemo(movie: movie));
    }

    void onTapFavorites(int index) {
      Movie movie = controlm.listFavoriteMovieGral![index];
      Get.to(() => VideoDemo(movie: movie));
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
                    'Populares de MovieKaiser',
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
                    itemCount: controlm.listPopularMovieGral!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final movie = controlm.listPopularMovieGral![index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => onTapPopular(index),
                            child: Image.network(
                              movie.image,
                              height: 120,
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tendencias',
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
                    itemCount: controlm.listTrendMovieGral!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final movie = controlm.listTrendMovieGral![index];
                      // Aquí debes definir cómo se muestra cada imagen en la lista
                      try {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                onTapTrend(index);
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
          SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Mi lista',
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
                    itemCount: controlm.listFavoriteMovieGral!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final movie = controlm.listFavoriteMovieGral![index];
                      // Aquí debes definir cómo se muestra cada imagen en la lista
                      try {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                onTapFavorites(index);
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
        ],
      ),
    );
  }
}
