import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/data/data_source/remote_data_source.dart';
import 'package:yamaiter/data/params/chat_room_by_id_params.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/main/client/client_main_screen.dart';
import 'package:yamaiter/presentation/journeys/main/lawyer/lawyer_main_screen.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _initScreenUtil();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
      builder: (context, state) {
        if (state.currentUserType == UserType.client) {
          return const ClientMainScreen();
        }

        return const LawyerMainScreen();
      },
    );
  }

  /// to ensure init ScreenUtil
  void _initScreenUtil() {
    if (ScreenUtil.screenHeight == 0) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      ScreenUtil.init(height: h, width: w);
    }
  }
}
