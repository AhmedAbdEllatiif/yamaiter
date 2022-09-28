import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';

import '../../data/params/register_lawyer_request_params.dart';
import '../entities/app_error.dart';

abstract class RemoteRepository {
  /// login
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams);

  /// registerLawyer
  Future<Either<AppError, RegisterResponseEntity>> registerLawyer(
      RegisterLawyerRequestParams registerLawyerRequestParams);

  /// about
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getAboutApp(
      String userToken);

  /// terms and conditions
  Future<Either<AppError, List<SideMenuPageResponseModel>>>
      getTermsAndConditions(String userToken);

  /// privacy
  Future<Either<AppError, List<SideMenuPageResponseModel>>>
  getPrivacy(String userToken);

}
