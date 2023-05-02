import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/multi_part_post_request.dart';
import 'package:yamaiter/data/params/update_profile/update_lawyer_profile.dart';

import '../../../request_type.dart';

class UpdateLawyerRequest extends MultiPartPostRequest<UpdateLawyerParams> {
  @override
  Future<http.MultipartRequest> call(UpdateLawyerParams params) async {
    var request = initMultiPartPostRequest(
        requestType: RequestType.updateLawyerProfile, token: params.userToken);

    //==> first_name
    if (params.firstName.isNotEmpty) {
      request.fields["first_name"] = params.firstName;
    }

    //==> last_name
    if (params.lastName.isNotEmpty) {
      request.fields["last_name"] = params.lastName;
    }

    //==> phone
    if (params.mobile.isNotEmpty) {
      request.fields["phone"] = params.mobile;
    }

    //==> email
    if (params.email.isNotEmpty) {
      request.fields["email"] = params.email;
    }

    //==> governorates
    if (params.governorate.trim().isNotEmpty) {
      log("governorates >> ${params.governorate.trim()}");
      request.fields["governorates"] = params.governorate;
    }

    //==> court
    if (params.court.trim().isNotEmpty) {
      log("court_name >> ${params.court.trim()}");
      request.fields["court_name"] = params.court;
    }

    //==> description
    if (params.description.trim().isNotEmpty) {
      log("description >> ${params.description.trim()}");
      request.fields["description"] = params.description;
    }

    //==> profile_image
    if (params.image.trim().isNotEmpty) {
      // create MultipartFile to add to files with request
      final photoId = http.MultipartFile.fromBytes(
        "profile_image", // field name
        File(params.image).readAsBytesSync(),
        filename: params.image,
      );

      // add image to upload
      request.files.add(photoId);
    }

    // return the request
    return request;
  }
}
