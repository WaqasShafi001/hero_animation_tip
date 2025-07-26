import 'package:flutter/material.dart';
import 'package:hero_animation_tip/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'SF Pro Display'),
      // home: PhotoGalleryScreen(),
      home: HomeScreen(),
    );
  }
}
