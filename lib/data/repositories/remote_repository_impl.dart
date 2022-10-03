import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/auth/login/login_response.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/sos/sos_model.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';

import '../data_source/remote_data_source.dart';
import '../models/auth/login/login_request.dart';
import '../models/success_model.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Login
  @override
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams) async {
    try {
      // build a LoginRequestModel
      final loginRequestModel = LoginRequestModel(
          email: loginRequestParams.email,
          password: loginRequestParams.password,
          rememberMe: "true");

      // send login request
      final result = await remoteDataSource.login(loginRequestModel);

      // success to login
      if (result is LoginResponseModel) {
        return Right(result);
      }

      // failed to login
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// register lawyer
  @override
  Future<Either<AppError, RegisterResponseEntity>> registerLawyer(
      RegisterLawyerRequestParams registerLawyerRequestParams) async {
    try {
      // build a RegisterRequestModel
      final registerRequestModel = RegisterRequestModel(
        name: registerLawyerRequestParams.name,
        phone: registerLawyerRequestParams.phone,
        email: registerLawyerRequestParams.email,
        governorates: registerLawyerRequestParams.governorates,
        courtName: registerLawyerRequestParams.courtName,
        password: registerLawyerRequestParams.password,
        acceptTerms: "yes",
        idPhoto: File(registerLawyerRequestParams.idPhotoPath),
      );

      // send login request
      final result =
          await remoteDataSource.registerLawyer(registerRequestModel);

      // success to register
      if (result is RegisterResponseModel) {
        return Right(result);
      }

      // failed to register
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getAboutApp(
      String userToken) async {
    try {
      // send get about request
      final result = await remoteDataSource.getAbout(userToken);

      // received about
      if (result is List<SideMenuPageResponseModel>) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// TermsAndConditionResponseModel
  @override
  Future<Either<AppError, List<SideMenuPageResponseModel>>>
      getTermsAndConditions(String userToken) async {
    try {
      // send get about request
      final result = await remoteDataSource.getTermsAndConditions(userToken);

      // received about
      if (result is List<SideMenuPageResponseModel>) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// privacy
  @override
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getPrivacy(
      String userToken) async {
    try {
      // send get privacy request
      final result = await remoteDataSource.getPrivacyAndPolicy(userToken);

      // received privacy
      if (result is List<SideMenuPageResponseModel>) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }


  /// Help
  @override
  Future<Either<AppError, List<HelpResponseModel>>> getHelp(
      String userToken) async {
    try {
      // send get help request
      final result = await remoteDataSource.getHelp(userToken);

      // received help
      if (result is List<HelpResponseModel>) {
        return Right(result);
      }

      // failed to get help
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createSos
  @override
  Future<Either<AppError, SuccessModel>> createSos(CreateSosParams createSosParams) async{
    try {
      // send get help request
      final result = await remoteDataSource.createSos(createSosParams);

      // received help
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to get help
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getMySosList
  @override
  Future<Either<AppError, List<SosEntity>>> getMySosList(String userToken) async{
    try {
      // send get my sos list request
      final result = await remoteDataSource.getMySos(userToken);

      // received my sos list
      if (result is MySosResponseModel) {
        return Right(result.mySosList);
      }

      // failed to get my sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }
}
