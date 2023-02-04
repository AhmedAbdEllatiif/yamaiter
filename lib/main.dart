import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yamaiter/base/base_material_app.dart';

import 'common/screen_utils/screen_util.dart';

import 'di/rest_api_di.dart' as get_init_rest_api;
import 'di/repositories_di.dart' as get_init_repositories;
import 'di/cubit_di.dart' as get_init_cubit;
import 'di/usecases_di.dart' as get_init_usecases;
import 'di/data_source_di.dart' as get_init_datasource;

void main() async {
  /// ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  /// set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  /// init getIt
  await get_init_rest_api.init();
  await get_init_repositories.init();
  await get_init_cubit.init();
  await get_init_usecases.init();
  await get_init_datasource.init();

  /// init screen util
  ScreenUtil.init();

  runApp(const BaseMaterialApp());
}
