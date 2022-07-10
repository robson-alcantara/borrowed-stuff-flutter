import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoContainer extends StatefulWidget {
  final double height;
  final Function(String) onChanged;
  final String initialPhotoPath;

  const PhotoContainer(
      {required this.initialPhotoPath,
      this.height = 180.0,
      required this.onChanged});

  @override
  _PhotoContainerState createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<PhotoContainer> {
  late File _image;
  late ImagePicker imagePicker;

  Future getImage() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
      widget.onChanged(image.path ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
 _image = File(widget.initialPhotoPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: getImage,
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _image == null ? const Text('Sem foto.') : Image.file(_image),
            ),
          ),
        ),
      ),
    );
  }
}
