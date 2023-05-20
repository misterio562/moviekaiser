import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/pages/homepages/homepages.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/controller/controllerUser.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ControlUser controlu = Get.find();
  ControlMovie controlm = Get.find();

  // late SharedPreferences prefs;
  // bool isLoggedIn = false;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String userErrorText = "";
  String passErrorText = "";

  // Future<void> checkLoginStatus() async {
  //   prefs = await SharedPreferences.getInstance();
  //   isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  //   if (isLoggedIn) {
  //     controlm.getMovieGral().then((value) {
  //       Navigator.pushNamed(context, '/home');
  //     });
  //   }
  // }

  void validateFields() {
    setState(() {
      userErrorText =
          user.text.isEmpty ? 'El campo de correo es obligatorio' : '';
      passErrorText =
          pass.text.isEmpty ? 'El campo de contraseña es obligatorio' : '';
    });

    if (user.text.isNotEmpty && pass.text.isNotEmpty) {
      controlu.validarUser(user.text, pass.text).then((value) {
        if (controlu.listaUserLogin!.isEmpty) {
          Get.snackbar('Usuarios', 'Usuario no Encontrado',
              duration: const Duration(seconds: 3),
              icon: const Icon(Icons.info),
              shouldIconPulse: true,
              backgroundColor: Colors.yellow);
        } else {
          print(controlu.listaUserLogin![0].id);
          controlm.getFavoritesMovies(controlu.listaUserLogin![0].id);
          controlm.getTrendMovies();
          controlm.getPopularMovies().then((value) {
            Navigator.pushNamed(context, '/home');
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    errorText: userErrorText.isNotEmpty ? userErrorText : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    errorText: passErrorText.isNotEmpty ? passErrorText : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          validateFields();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/register");
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Recordar Contraseña',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
