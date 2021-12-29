import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../full_photo_screen.dart';

class FullPhotoView extends StatelessWidget {
  const FullPhotoView({Key? key, required this.arguments}) : super(key: key);

  final FullPhotoArgument arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(arguments.imageUrl),
      ),
    );
  }
}
