import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../full_photo_screen.dart';

class FullPhotoView extends StatelessWidget {
  const FullPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FullPhotoArgument;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(args.imageUrl),
      ),
    );
  }
}
