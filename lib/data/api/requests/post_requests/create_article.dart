import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/multi_part_post_request.dart';
import 'package:yamaiter/data/params/create_article_params.dart';

class CreateArticleRequest extends MultiPartPostRequest<CreateArticleParams> {
  @override
  Future<http.MultipartRequest> call(CreateArticleParams params) async {
    var request = initMultiPartPostRequest(
        requestType: RequestType.createArticle, token: params.token);

    request.fields["title"] = params.requestModel.title;
    request.fields["description"] = params.requestModel.description;

    // create MultipartFile to add to files with request
    final images = imagesToUpload(params.requestModel.imageList);

    // add image to upload
    request.files.addAll(images);

    // return a request
    return request;
  }

  /// to return a list of images files to upload
  List<http.MultipartFile> imagesToUpload(List<String> paths) {
    // init list of MultipartFile
    final List<http.MultipartFile> imageList = [];

    // loop on paths to create file to be added into the MultipartFile list
    // to be uploaded
    for (var element in paths) {
      final imageToUpload = http.MultipartFile.fromBytes(
        "image[]", // field name
        File(element).readAsBytesSync(),
        filename: element,
      );

      imageList.add(imageToUpload);
    }

    // return the MultipartFile list
    return imageList;
  }
}
