import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/get_app_announcements.dart';

import '../../constants.dart';

class GetAppAnnouncements extends GetRequest<GetAnnouncementsParams> {
  @override
  Future<http.Response> call(GetAnnouncementsParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.appAnnouncements,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.announcementPlace: params.page,
        });
    return response;
  }
}
