import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/models/ads/ad_model.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/article/article_model.dart';
import 'package:yamaiter/data/models/auth/login/login_response.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/sos/sos_model.dart';
import 'package:yamaiter/data/models/tax/tax_model.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
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
  Future<Either<AppError, SuccessModel>> createSos(
      CreateSosParams createSosParams) async {
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
  Future<Either<AppError, List<SosEntity>>> getMySosList(
      String userToken) async {
    try {
      // send get my sos list request
      final result = await remoteDataSource.getMySos(userToken);

      // received my sos list
      if (result is SosResponseModel) {
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

  /// getAllSosList
  @override
  Future<Either<AppError, List<SosEntity>>> getAllSosList(
      GetAllSosParams params) async {
    try {
      // send get all sos list request
      final result = await remoteDataSource.getAllSos(params);

      // received all sos list
      if (result is SosResponseModel) {
        return Right(result.mySosList);
      }

      // failed to get all sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("Error: $e");
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createArticle
  @override
  Future<Either<AppError, SuccessModel>> createArticle(
      CreateOrUpdateArticleParams params) async {
    try {
      // send create article request
      final result = await remoteDataSource.createArticle(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, ArticleEntity>> getSingleArticle(
      GetSingleArticleParams params) async {
    try {
      // send create article request
      final result = await remoteDataSource.fetchSingleArticleArticle(params);

      // received success
      if (result is ArticleModel) {
        return Right(result);
      }

      // failed to create article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, List<ArticleEntity>>> getMyArticles(
      String params) async {
    try {
      // send fetch my articles request
      final result = await remoteDataSource.fetchMyArticles(params);

      // received success
      if (result is List<ArticleModel>) {
        return Right(result);
      }

      // failed to fetch my  articles
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// deleteArticle
  @override
  Future<Either<AppError, SuccessModel>> deleteArticle(
      DeleteArticleParams deleteArticleParams) async {
    try {
      // send delete article request
      final result = await remoteDataSource.deleteArticle(deleteArticleParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to delete article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// updateArticle
  @override
  Future<Either<AppError, SuccessModel>> updateArticle(
      CreateOrUpdateArticleParams params) async {
    try {
      // send update article request
      final result = await remoteDataSource.updateArticle(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createAd
  @override
  Future<Either<AppError, SuccessModel>> createAd(
      CreateAdParams createAdParams) async {
    try {
      // send update article request
      final result = await remoteDataSource.createAd(createAdParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createTax
  @override
  Future<Either<AppError, SuccessModel>> createTax(
      CreateTaxParams params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.createTax(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getInProgressTaxes
  @override
  Future<Either<AppError, List<TaxEntity>>> getInProgressTaxes(
      String params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.fetchInProgressTaxes(params);

      // received success
      if (result is List<TaxModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getCompletedTaxes
  @override
  Future<Either<AppError, List<TaxEntity>>> getCompletedTaxes(
      String params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.fetchCompletedTaxes(params);

      // received success
      if (result is List<TaxModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, List<AdEntity>>> getMyAdsList(String userToken) async{
    try {
      // send create tax request
      final result = await remoteDataSource.getMyAds(userToken);

      // received success
      if (result is List<AdModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }


}
