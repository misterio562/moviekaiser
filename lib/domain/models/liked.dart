class Liked {
  late int idUser;
  late int idMovie;

  Liked({required this.idUser, required this.idMovie});

  factory Liked.desdeJson(Map<String, dynamic> jsonMap) {
    return Liked(
        idUser: int.parse(jsonMap['idUser']),
        idMovie: int.parse(jsonMap['idMovie']));
  }
}
