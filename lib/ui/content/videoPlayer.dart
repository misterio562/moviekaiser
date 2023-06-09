import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviekaiser/domain/controller/controllerFavorite.dart';
import 'package:moviekaiser/domain/controller/controllerLiked.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:video_player/video_player.dart';

import '../../domain/models/movie.dart';

class VideoDemo extends StatefulWidget {
  final Movie movie;

  const VideoDemo({Key? key, required this.movie}) : super(key: key);

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool showFullDescription = false;
  bool isLiked = false;
  bool isFavorite = false;
  bool showPlayPauseButton = true;
  bool isPlaying = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    isFavorite = false;

    final controlLiked = Get.find<ControlLiked>();
    final controlUser = Get.find<ControlUser>();
    final controlf = Get.find<ControlFavorite>();
    final idUser = controlUser.listaUserLogin![0].id;
    final idMovie = widget.movie.id;
    controlLiked.getLikedByIdUser(idUser, idMovie).then((result) {
      setState(() {
        isLiked = result;
      });
    });

    controlf.getFavoriteMovie(idUser, idMovie).then((value) {
      setState(() {
        isFavorite = value;
      });
    });

    _controller = VideoPlayerController.network(widget.movie.video);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);

    // startTimer();
  }

  // void startTimer() {
  //   _timer = Timer(const Duration(seconds: 3), () {
  //     setState(() {
  //       showPlayPauseButton = false;
  //     });
  //   });
  //   resetTimer();
  // }

  void resetTimer() {
    setState(() {
      showPlayPauseButton = false;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        // showPlayPauseButton = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.pause();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ControlMovie controlm = Get.find();
    ControlLiked controll = Get.find();
    ControlUser controlu = Get.find();
    ControlFavorite controlf = Get.find();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          // controlm
                          //     .getMovieGral()
                          //     .then((value) => Get.toNamed('/listmovie'));
                          _controller.pause(); // Pausar el video
                          _controller.seekTo(
                              Duration.zero); // Volver al inicio del video
                          _controller.dispose(); // Liberar recursos del video
                          controlm
                              .getFavoritesMovies(
                                  controlu.listaUserLogin![0].id)
                              .then((value) {
                            Navigator.pushNamed(context, '/home');
                          });
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                      ),
                    ),
                    Image.network(widget.movie.image, width: 200, height: 200),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.movie.year,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                          width: 20,
                        ),
                        Flexible(
                          child: Text(
                            widget.movie.duration,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            int iu = controlu.listaUserLogin![0].id;
                            int im = widget.movie.id;
                            if (isLiked) {
                              controll.deleteLike(iu, im);
                              controlm.deleteLike(im);
                              setState(() {
                                isLiked = !true;
                                widget.movie.likes--;
                              });
                            } else {
                              controll.addLike(iu, im);
                              controlm.addLike(im);
                              setState(() {
                                isLiked = true;
                                widget.movie.likes++;
                              });
                            }
                          },
                          icon: Icon(isLiked
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.likes
                              .toString(), // Aquí puedes cambiar por la cantidad real de "me gusta"
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: () {
                                int iu = controlu.listaUserLogin![0].id;
                                int im = widget.movie.id;

                                if (isFavorite) {
                                  controlf.deleteFavoriteMovie(iu, im);
                                  controlm.listFavoriteMovieGral!
                                      .remove(widget.movie);
                                  setState(() {
                                    isFavorite = !true;
                                  });
                                } else {
                                  controlf.addToFavoriteMovies(iu, im);
                                  setState(() {
                                    isFavorite = true;
                                  });
                                }
                              },
                              icon: Icon(isFavorite
                                  ? Icons.delete_outline
                                  : Icons.playlist_add),
                            ), // Icono arriba
                            Text(
                              isFavorite
                                  ? "Quitar de tu lista"
                                  : "Añadir a lista", // Texto
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text(
                              'Sinopsis',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showFullDescription = !showFullDescription;
                                });
                              },
                              child: Text(
                                widget.movie.description,
                                maxLines: showFullDescription ? null : 10,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // resetTimer();

                                setState(() {
                                  showPlayPauseButton = !showPlayPauseButton;
                                });

                                // if (!showPlayPauseButton) {
                                //   _controller.play();
                                //   resetTimer();
                                // }
                                print("se presiono sobre el video");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                  if (_controller.value.isInitialized)
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                            isPlaying = false;
                                          } else {
                                            _controller.play();
                                            resetTimer();
                                            isPlaying = true;
                                          }
                                        });
                                      },
                                      icon: showPlayPauseButton
                                          ? Icon(
                                              isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              // _controller.value.isPlaying
                                              //     ? Icons.pause
                                              //     : Icons.play_arrow,
                                              size: 64,
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.trip_origin,
                                              color: Colors.transparent,
                                            ),
                                    )
                                  else
                                    CircularProgressIndicator(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                            ),
                          ],
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
