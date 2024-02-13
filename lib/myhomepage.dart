import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_app/display_pitcture.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  List<String> imagePaths = [];
  String imagePath = 'hi';
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: imagePath != 'hi'
                      ? GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageDisplayScreen(
                                imagePaths: imagePaths,
                              ),
                            ));
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageDisplayScreen(
                                  imagePaths: imagePaths,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 5, color: Colors.white),
          color: Colors.black,
        ),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.black,
          onPressed: () async {
            try {
              final image = await _controller.takePicture();

              if (!mounted) return;

              await GallerySaver.saveImage(image.path);

              setState(() {
                imagePath = image.path;
                imagePaths.add(imagePath);
              });
            } catch (e) {
              'error';
            }
          },
          child: const Icon(
            Icons.camera_alt,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
