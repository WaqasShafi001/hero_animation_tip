// import 'package:flutter/material.dart';

// class ImageData {
//   final int id;
//   final String name;
//   final Color color;
//   final String emoji;

//   ImageData({required this.id, required this.name, required this.color, required this.emoji});
// }

import 'package:flutter/material.dart';

class ImageData {
  final int id;
  final String name;
  final Color color;
  final String emoji;
  final String? description;
  final String? location;
  final double? rating;

  ImageData({
    required this.id,
    required this.name,
    required this.color,
    required this.emoji,
    this.description,
    this.location,
    this.rating,
  });
}