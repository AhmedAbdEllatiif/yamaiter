import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  final String fileUrl;
  final String fileName;

  FileDownloader({
    required this.fileUrl,
    required this.fileName,
  });

  Future<String> getLocalFilePath() async {
    try {
      // if not starts http that means the file is locally file
      if (!fileUrl.startsWith("http")) return fileUrl;

      //==> init bodyBytes
      final bodyBytes = await _downloadFile();

      //==> init localPath
      final localPath = await _buildLocalPathFile();

      //==> build the file
      final file = await _writeFileIfNotExists(
        localPath: localPath,
        bytes: bodyBytes,
      );

      //==> return file path
      return file.path;
    } catch (e) {
      rethrow;
    }
  }

  /// to download the file
  Future<Uint8List> _downloadFile() async {
    final uri = Uri.tryParse(fileUrl);
    if (uri == null) {
      throw Exception(
          "FileDownloader >> _downloadFile() >> Failed to parse fileUrl");
    }

    //==> init client
    final client = http.Client();

    //==> start request
    final response = await client.get(uri);

    return response.bodyBytes;
  }

  /// build local path
  Future<String> _buildLocalPathFile() async {
    try {
      final documentsDir = (await getApplicationDocumentsDirectory()).path;
      return '$documentsDir/$fileName';
    } catch (e) {
      throw Exception("FileDownloader >> _buildLocalPathFile() >> "
          "Failed to getApplicationDocumentsDirectory() \n Error: $e");
    }
  }

  /// write new file if not exists
  Future<File> _writeFileIfNotExists({
    required String localPath,
    required Uint8List bytes,
  }) async {
    try {
      //==> build file
      final file = File(localPath);

      //==> return the file if already exists
      if (_isFileAlreadyExists(file)) return file;

      //==> write to the file if not exists
      return await file.writeAsBytes(bytes);
    } catch (e) {
      throw Exception("FileDownloader >> _addFileIfNotExists() >> "
          "Failed to addFile() \n Error: $e");
    }
  }

  /// return true if the file is exists
  bool _isFileAlreadyExists(File file) {
    return file.existsSync();
  }
}
