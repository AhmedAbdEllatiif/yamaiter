import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:filesize/filesize.dart';
import 'my_image_picker_state.dart';

class MyImagePicker {
  final num maxImageSize;

  MyImagePicker({
    required this.maxImageSize,
  });

  Future<MyImagePickerState> selectNewImage() async {
    try {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.gallery,
      );

      //==> check if no Image selected
      if (result == null) {
        return NoImageSelected();
      }

      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      //==> init selected Image size
      final selectedImageSize = bytes.length;

      /*
        *
        * max Image size reached
        *
        * */
      if (selectedImageSize > maxImageSize) {
        return MaxImageSizeReached(
          maxSizeToSelect: filesize(maxImageSize),
        );
      }

      /*
        *
        * Success to select Image
        *
        * */
      return ImagePickedSuccessfully(
        selectedImage: image,
        imageName: result.name,
        imagePath: result.path,
        imageSize: bytes.length,
      );
    } catch (e) {
      log("MyImagePicker >> error: $e");
      return (ErrorWhilePickingImage(errorMessage: "$e"));
    }
  }
}
