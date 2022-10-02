import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yamaiter/base/base_material_app.dart';

import 'common/screen_utils/screen_util.dart';

import 'di/git_it.dart' as get_it;

void main() async {
  /// ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  /// set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  /// init getIt
  await get_it.init();

  /// init screen util
  ScreenUtil.init();

  runApp(const BaseMaterialApp());
}
