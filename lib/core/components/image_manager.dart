import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageManager extends StatefulWidget {
  const ImageManager({super.key,
    this.networkImagePath,
    required this.onImagePicked,
    this.selectedImageBuilder,
    this.unselectedImageBuilder
  });

  final String? networkImagePath;
  final void Function(String path) onImagePicked;
  final Widget Function(String path)? selectedImageBuilder;
  final Widget? unselectedImageBuilder;

  @override
  State<ImageManager> createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: pickImage,
        child: SizedBox(
          height: 200,
          width: 200,
          child: selectedFileImage != null ?
          widget.selectedImageBuilder != null ?
              widget.selectedImageBuilder!(selectedFileImage!.path):
          Image.file(File(selectedFileImage!.path)):
          widget.networkImagePath != null?
          Image.network(widget.networkImagePath!):
          widget.unselectedImageBuilder !=null?
              widget.unselectedImageBuilder!:
          Image.asset('assets/images/flag.png'),
        ));
  }


  XFile? selectedFileImage;
  pickImage()async{
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      widget.onImagePicked(image.path);
      setState(() {
        selectedFileImage = image;
      });
    }
  }
}
