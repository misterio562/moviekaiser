import 'package:flutter/material.dart';
import 'package:moviekaiser/domain/controller/movie/controllerMovie.dart';
import 'package:moviekaiser/ui/app.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ControlMovie());
  runApp(const App());
}
