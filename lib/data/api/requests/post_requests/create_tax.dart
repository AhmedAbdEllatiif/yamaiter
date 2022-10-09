import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import '../../../params/create_tax_params.dart';
import '../../constants.dart';
import '../multi_part_post_request.dart';

class CreateTaxRequest extends MultiPartPostRequest<CreateTaxParams> {
  @override
  Future<http.MultipartRequest> call(CreateTaxParams params) async {
    var request = initMultiPartPostRequest(
        requestType: RequestType.createTax, token: params.userToken);
    request.fields["tax_name"] = params.createTaxRequestModel.taxName;
    request.fields["tax_password"] = params.createTaxRequestModel.taxPassword;
    request.fields["notes"] = params.createTaxRequestModel.note;

    // create MultipartFile to add to files with request
    final photoId = http.MultipartFile.fromBytes(
      "tax_file", // field name
      File(params.createTaxRequestModel.taxFile).readAsBytesSync(),
      filename: params.createTaxRequestModel.taxFile,
    );

    // add image to upload
    request.files.add(photoId);

    // return the request
    return request;
  }
}
