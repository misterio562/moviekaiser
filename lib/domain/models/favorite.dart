class Favorite {
  late int idUser;
  late int idMovie;

  Favorite({required this.idUser, required this.idMovie});

  factory Favorite.desdeJson(Map<String, dynamic> jsonMap) {
    return Favorite(
        idUser: int.parse(jsonMap['idUser']),
        idMovie: int.parse(jsonMap['idMovie']));
  }
}
