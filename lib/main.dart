import 'package:flutter/material.dart';
import 'package:gps/homescreen.dart';
import 'package:gps/test.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: {
        Homescreen.RoutName:(context) => Homescreen(),
        MapSample.name:(context) => MapSample()
      },
      initialRoute:  Homescreen.RoutName,
    );
  }
}