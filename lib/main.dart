import 'package:flutter/material.dart';
import 'package:yamaiter/base/base_material_app.dart';
import 'package:yamaiter/router/transition_page_route.dart';

import 'common/screen_utils/screen_util.dart';
import 'router/routes.dart';

import 'di/git_it.dart' as get_it;

void main() async {
  /// init getIt
  await get_it.init();

  /// init screen util
  ScreenUtil.init();

  runApp(const BaseMaterialApp());
}

