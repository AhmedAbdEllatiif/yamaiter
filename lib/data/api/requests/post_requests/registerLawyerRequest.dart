import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/post_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';

class RegisterLawyerRequest extends PostRequest<RegisterRequestModel> {
  @override
  Future<http.MultipartRequest> call(RegisterRequestModel params) async {
    var request =
        initPostRequest(requestType: RequestType.registerLawyer, token: "");
    request.fields["email"] = params.email;
    request.fields["name"] = params.name;
    request.fields["phone"] = params.phone;
    request.fields["governorates"] = params.governorates;
    request.fields["court_name"] = params.courtName;
    request.fields["password"] = params.password;
    request.fields["password_confirmation"] = params.password;
    request.fields["accept_terms"] = params.acceptTerms;

    // create MultipartFile to add to files with request
    final photoId = http.MultipartFile.fromBytes(
      "id_photo", // field name
      File(params.idPhoto.path).readAsBytesSync(),
      filename: params.idPhoto.path,
    );

    // add image to upload
    request.files.add(photoId);

    // return the request
    return request;
  }
}
