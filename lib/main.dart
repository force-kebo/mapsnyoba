import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter nnyoba maps',
      theme: ThemeData(
        primaryColor: Colors.blueGrey
      ),
      home: HomePage(),
    );
  }
}
