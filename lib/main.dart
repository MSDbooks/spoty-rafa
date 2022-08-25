import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spotRafa/home.dart';


Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotyRafa',
      theme: ThemeData.dark(),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

