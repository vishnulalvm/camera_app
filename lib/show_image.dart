import 'dart:io';

import 'package:flutter/material.dart';

class ShowPictureScreen extends StatelessWidget {
  final List<String> imagePaths;
  final int index;

  const ShowPictureScreen({super.key, required this.imagePaths, required this.index,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),

      body: Image.file(File(imagePaths[index])),
    );
  }
}