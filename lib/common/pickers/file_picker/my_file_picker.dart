import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';

import 'my_file_picker_state.dart';

class MyFilePicker {
  final num maxFileSize;

  MyFilePicker({
    required this.maxFileSize,
  });

  Future<MyFilePickerState> selectNewFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      //==> check if no file selected
      if (result == null || result.files.single.path == null) {
        return NoFileSelected();
      }

      //==> init selected file size
      final selectedFileSize = result.files.single.size;

      /*
        *
        * max file size reached
        *
        * */
      if (selectedFileSize > maxFileSize) {
        return MaxFileSizeReached(
          maxSizeToSelect: filesize(maxFileSize),
        );
      }

      /*
        *
        * Success to select file
        *
        * */
      return FilePickedSuccessfully(selectedFile: result.files.single);
    } catch (e) {
      log("MyFilePicker >> error: $e");
      return (ErrorWhilePickingFile(errorMessage: "$e"));
    }
  }
}
