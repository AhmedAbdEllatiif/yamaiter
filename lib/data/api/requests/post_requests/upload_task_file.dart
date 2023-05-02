import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/multi_part_post_request.dart';

import '../../../models/tasks/upload_task_params.dart';
import '../../request_type.dart';
class UploadTaskFileRequest extends MultiPartPostRequest<UploadTaskFileParams> {
  @override
  Future<http.MultipartRequest> call(UploadTaskFileParams params) async {
    var request = initMultiPartPostRequest(
      requestType: RequestType.uploadTaskFile,
      token: params.userToken,
      id: params.taskId.toString(),
    );

    // create MultipartFile to add to files with request
    final files = filesToUpload(params.files);

    // add files to upload
    //request.files.addAll(files);

    // upload one file
    request.files.add(files[0]);

    // return a request
    return request;
  }

  /// to return a list of images files to upload
  List<http.MultipartFile> filesToUpload(List<String> paths) {
    // init list of MultipartFile
    final List<http.MultipartFile> files = [];

    // loop on paths to create file to be added into the MultipartFile list
    // to be uploaded
    for (var element in paths) {
      final imageToUpload = http.MultipartFile.fromBytes(
        "task_file", // field name
        File(element).readAsBytesSync(),
        filename: element,
      );

      files.add(imageToUpload);
    }

    // return the MultipartFile list
    return files;
  }
}
