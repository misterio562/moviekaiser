import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ControlUser controlu = Get.find();

  TextEditingController nombre = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController passw = TextEditingController();

  String nombreErrorText = '';
  String userErrorText = '';
  String passwErrorText = '';

  void validateFields() {
    setState(() {
      nombreErrorText =
          nombre.text.isEmpty ? 'El campo de nombre es obligatorio' : '';
      userErrorText =
          user.text.isEmpty ? 'El campo de correo es obligatorio' : '';
      passwErrorText =
          passw.text.isEmpty ? 'El campo de contraseña es obligatorio' : '';
    });

    if (nombre.text.isNotEmpty &&
        user.text.isNotEmpty &&
        passw.text.isNotEmpty) {
      controlu.crearUser(nombre.text, user.text, passw.text).then((value) {
        String mensaje = controlu.listaMensajes![0].mensaje;
        Color snackbarColor = Colors.green;
        IconData icon = Icons.check_circle_outline;

        if (mensaje == "Usuario no almacenado" ||
            mensaje == "Este email ya está en uso") {
          snackbarColor = Colors.red;
          icon = Icons.error_outline;
        }else{
          Get.back();
        }

        Get.snackbar(
          '',
          mensaje,
          duration: const Duration(seconds: 3),
          icon: Icon(icon),
          shouldIconPulse: true,
          backgroundColor: snackbarColor,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Crear Cuenta",
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.27),
              child: Column(children: [
                TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Añadir un nombre',
                    errorText:
                        nombreErrorText.isNotEmpty ? nombreErrorText : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Dirección de correo',
                    errorText: userErrorText.isNotEmpty ? userErrorText : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: passw,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Añadir una contraseña',
                    errorText:
                        passwErrorText.isNotEmpty ? passwErrorText : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
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
                    ]),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Inicio',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.white,
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
