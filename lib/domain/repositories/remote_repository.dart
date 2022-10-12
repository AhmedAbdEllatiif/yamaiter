import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';

import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';

import '../../data/models/success_model.dart';
import '../../data/params/all_sos_params.dart';
import '../../data/params/create_article_params.dart';
import '../../data/params/register_lawyer_request_params.dart';
import '../entities/app_error.dart';
import '../entities/data/article_entity.dart';

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
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getPrivacy(
      String userToken);

  /// help
  Future<Either<AppError, List<HelpResponseModel>>> getHelp(String userToken);

  /// create sos
  Future<Either<AppError, SuccessModel>> createSos(
      CreateSosParams createSosParams);

  /// return a list of current user sos
  Future<Either<AppError, List<SosEntity>>> getMySosList(String userToken);

  /// return a list of all  sos
  Future<Either<AppError, List<SosEntity>>> getAllSosList(GetAllSosParams params);

  /// create article
  Future<Either<AppError, SuccessModel>> createArticle(
      CreateOrUpdateArticleParams params);

  /// update article
  Future<Either<AppError, SuccessModel>> updateArticle(
      CreateOrUpdateArticleParams params);

  /// get single article
  Future<Either<AppError, ArticleEntity>> getSingleArticle(
      GetSingleArticleParams params);

  /// get my articles
  Future<Either<AppError, List<ArticleEntity>>> getMyArticles(String params);

  /// delete article
  Future<Either<AppError, SuccessModel>> deleteArticle(
      DeleteArticleParams deleteArticleParams);

  /// create sos
  Future<Either<AppError, SuccessModel>> createAd(
      CreateAdParams createAdParams);

  /// create tax
  Future<Either<AppError, SuccessModel>> createTax(
      CreateTaxParams params);


  /// get my in progress taxes
  Future<Either<AppError, List<TaxEntity>>> getInProgressTaxes(String params);

  /// get my completed taxes
  Future<Either<AppError, List<TaxEntity>>> getCompletedTaxes(String params);


  /// return a list my  ads
  Future<Either<AppError, List<AdEntity>>> getMyAdsList(String userToken);
}
