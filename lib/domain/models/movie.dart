class Movie{
  late int id;
  late String title;
  late String description;
  late String image;
  late String year;
  late String duration;
  late String video;
  late int idGender;

  Movie(
    {
      required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.year,
      required this.duration,
      required this.video,
      required this.idGender
    }
  );

  factory Movie.desdeJson(Map<String, dynamic> jsonMap){
    return Movie(
      id: int.parse(jsonMap['id']),
      title: jsonMap['title'],
      description: jsonMap['description'],
      image: jsonMap['image'],
      year: jsonMap['year'],
      duration: jsonMap['duration'],
      video: jsonMap['video'],
      idGender: int.parse(jsonMap['idGender'])
    );
  }

}