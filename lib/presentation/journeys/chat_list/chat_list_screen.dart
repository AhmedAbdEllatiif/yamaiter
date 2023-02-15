import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/presentation/journeys/chat_list/chat_item.dart';
import 'package:yamaiter/presentation/logic/cubit/fetch_chat_list/fetch_chat_list_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/fetch_lawyers/fetch_lawyers_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/enum/ads_pages.dart';
import '../../../common/functions/get_authoried_user.dart';
import '../../../common/functions/navigate_to_login.dart';
import '../../../domain/entities/screen_arguments/chat_room_args.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/ads_widget.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final FetchChatListCubit _fetchChatListCubit;

  @override
  void initState() {
    super.initState();
    _fetchChatListCubit = getItInstance<FetchChatListCubit>();
    _fetchChatList();
  }

  @override
  void dispose() {
    _fetchChatListCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _fetchChatListCubit,
      child: Scaffold(

          /// appBar
          appBar: AppBar(
            title: const Text("المحادثات"),
          ),

          /// body
          body: Column(
            children: [
              //==> AdsWidget
              const AdsWidget(
                  adsPage: AdsPage.innerPage
              ),

              //==> chat list
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppUtils.mainPagesHorizontalPadding.w,
                  vertical: AppUtils.mainPagesVerticalPadding.h,
                ),
                child: BlocBuilder<FetchChatListCubit, FetchChatListState>(
                  builder: (context, state) {
                    log("State $state");
                    /*
                        *
                        *
                        * loading
                        *
                        *
                        * */
                    if (state is LoadingChatsList) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    /*
                    *
                    *
                    * empty chat list
                    *
                    *
                    * */
                    if (state is EmptyChatsList) {
                      return const Center(
                        child: Text("ليس لديك محادثات"),
                      );
                    }
                    /*
                    *
                    *
                    * unAuthenticated
                    *
                    *
                    * */
                    if (state is UnAuthorizedToFetchChatsList) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: AppErrorType.unauthorizedUser,
                          onPressedRetry: () => navigateToLogin(context),
                        ),
                      );
                    }

                    /*
                    *
                    *
                    * error
                    *
                    *
                    * */
                    if (state is ErrorWhileLoadingChatsList) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: state.appError.appErrorType,
                          onPressedRetry: () => _fetchChatList(),
                        ),
                      );
                    }

                    /*
                    *
                    *
                    * chat list fetched
                    *
                    *
                    * */
                    if (state is ChatsListFetched) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.receivedChatListEntity.length,

                        // separatorBuilder
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 10);
                        },

                        // itemBuilder
                        itemBuilder: (BuildContext context, int index) {
                          return ChatItem(
                            receivedChatListEntity:
                                state.receivedChatListEntity[index],
                            onItemPressed: () => _navigateToChatRoom(
                                state.receivedChatListEntity[index]),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              )),
            ],
          )),
    );
  }

  /// to fetch the chat list
  void _fetchChatList() {
    // init userToken
    final userToken = getUserToken(context);

    _fetchChatListCubit.fetchChatList(userToken: userToken);
  }

  /// to navigate to chat room id
  void _navigateToChatRoom(ReceivedChatListEntity chatEntity) async {
    await RouteHelper().chatRoomScreen(context,
        chatRoomArguments: ChatRoomArguments(
          authorizedUserEntity: getAuthorizedUserEntity(context),
          chatRoomId: chatEntity.chatId,
          chatChannel: chatEntity.chatChannel,
        ));

    if (!mounted) return;

    _fetchChatList();
  }
}
