import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplayScreen extends StatefulWidget {
  final List<String> imagePaths;
  const ImageDisplayScreen({super.key, required this.imagePaths});

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle image tap
            },
            child: Image.file(
              File(widget.imagePaths[index]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // Future<List<File>> getPhotosFromDirectory(String directoryPath) async {
  //   try {
  //     Directory directory = Directory(directoryPath);
  //     List<FileSystemEntity> files = directory.listSync();
  //     List<File> photos = [];

  //     // Filter out only image files
  //     for (var file in files) {
  //       if (file is File && file.path.endsWith('.jpg')) {
  //         photos.add(file);
  //       }
  //     }

  //     return photos;
  //   } catch (e) {
  //     print('Error getting photos: $e');
  //     return [];
  //   }
  // }
}
