import 'package:flutter/material.dart';
import 'package:moviekaiser/domain/controller/controllerLiked.dart';
import 'package:moviekaiser/domain/controller/controllerUser.dart';
import 'package:moviekaiser/domain/controller/controllerFavorite.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/ui/app.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  Get.put(ControlUser());
  Get.put(ControlMovie());
  Get.put(ControlLiked());
  Get.put(ControlFavorite());
  runApp(const App());
}

void setup() async {
  await Future.delayed(const Duration(seconds: 10));
  FlutterNativeSplash.remove();
}
