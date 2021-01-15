import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/login/implicit_index.dart';
import 'package:flutter_animations/screens/login/index.dart';
import 'package:flutter_animations/screens/new_implicit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home : LoginScreen2(),
      home : LoginScreen()
      // home: MySplash(),
      
      
    );
  }
}

