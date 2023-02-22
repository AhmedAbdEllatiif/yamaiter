import 'package:yamaiter/data/params/store_fb_token.dart';

class StoreFirebaseTokenRequestModel {
  final String firebaseToken;

  StoreFirebaseTokenRequestModel({required this.firebaseToken});


  factory StoreFirebaseTokenRequestModel.fromParams(
      {required StoreFirebaseTokenParams params}){
    return StoreFirebaseTokenRequestModel(firebaseToken: params.firebaseToken);
  }


  Map<String, String> toJson() {
    return {
      "fcm_token": firebaseToken,
    };
  }

}