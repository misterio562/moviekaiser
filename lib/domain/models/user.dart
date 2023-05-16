class User {
  late int id;
  late String nombre;
  late String user;
  late String password;

  User(
      {required this.id,
      required this.nombre,
      required this.user,
      required this.password});

  factory User.desdeJson(Map<String, dynamic> jsonMap) {
    return User(
        //los valores de la derecha son los nombre que estan en la base de datos,
        //los de la izquierda son los nombres que estan en la clase
        id: int.parse(jsonMap['idUser']),
        nombre: jsonMap['name'],
        user: jsonMap['email'],
        password: jsonMap['pass']);
  }
}
