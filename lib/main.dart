import 'package:flutter/material.dart';
import 'package:moviekaiser/domain/controller/controllerLiked.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';
import 'package:moviekaiser/domain/controller/controllerFavorite.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/ui/app.dart';
import 'package:get/get.dart';

void main() {
  //hello
  Get.put(ControlUser());
  Get.put(ControlMovie());
  Get.put(ControlLiked());
  Get.put(ControlFavorite());
  runApp(const App());
}
