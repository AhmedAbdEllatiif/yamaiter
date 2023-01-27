import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/logic/common/chat_room/chat_room_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/pusher/pusher_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/send_chat_message/send_chat_message_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../data/models/chats/message_item_model.dart';
import '../../../domain/entities/screen_arguments/chat_room_args.dart';
import '../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import 'my_chat_theme.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomArguments chatRoomArguments;

  const ChatRoomScreen({super.key, required this.chatRoomArguments});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  /// PusherCubit
  final PusherCubit pusherCubit = PusherCubit();

  /// ChatRoomCubit
  late final ChatRoomCubit _chatRoomCubit;

  /// SendChatMessageCubit
  late final SendChatMessageCubit _sendChatMessageCubit;

  /// _currentUser
  late final types.User _currentUser;

  /// list of room messages
  List<types.Message> _messages = [];

  /// ScrollController
  late final ScrollController _controller;

  // init chat_room room
  late final int chatRoomId;

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        /*if (_filterTasksCubit.state is! LastPageFilterTasksFetched) {
          _fetchTasks();
        }*/
        _loadMessages();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //==> init chatRoomId
    chatRoomId = widget.chatRoomArguments.chatRoomId;

    //==> init _controller
    _controller = ScrollController();
    _listenerOnScrollController();

    //==> init currentUser
    _initCurrentUser();

    //==> init cubits
    _chatRoomCubit = getItInstance<ChatRoomCubit>();
    _sendChatMessageCubit = getItInstance<SendChatMessageCubit>();
    pusherCubit.initPusher(chatChannel: widget.chatRoomArguments.chatChannel);

    //==> load messages
    _loadMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chatRoomCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _chatRoomCubit),
        BlocProvider(create: (context) => _sendChatMessageCubit),
        BlocProvider(create: (context) => pusherCubit),
      ],
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("محادثة"),
        ),

        /// body
        body: BlocListener<PusherCubit, PusherState>(
          listener: (context, state) {
            if (state is PusherNewMessageReceived) {
              final messageUserId = state.message.author.id;

              _addMessage(
                state.message,
                sentByCurrentUser: messageUserId == _currentUser.id,
              );
            } else {
              _handleOtherPusherState(state);
            }
          },
          child: chatRoomId == -1
              ? Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unHandledError,
                    onPressedRetry: () {
                      _loadMessages();
                    },
                  ),
                )
              : BlocConsumer<ChatRoomCubit, ChatRoomState>(
                  listener: (context, state) {
                  if (state is ChatRoomMessageFetched) {
                    _messages = state.messages;
                    // setState(() {
                    //
                    // });
                  }
                }, builder: (context, state) {
                  if (state is LoadingChatRoomMessages && _messages.isEmpty) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }

                  if (state is LoadingChatRoomMessages &&
                      _messages.isNotEmpty) {
                    return Column(
                      children: [
                        const LoadingWidget(),
                        Expanded(
                          child: Chat(
                            messages: _messages,
                            onAttachmentPressed: _handleAttachmentPressed,
                            onMessageTap: _handleMessageTap,
                            onPreviewDataFetched: _handlePreviewDataFetched,
                            onSendPressed: _handleSendPressed,
                            showUserAvatars: true,
                            showUserNames: true,
                            user: _currentUser,
                            scrollPhysics: const BouncingScrollPhysics(),
                            theme: const MyChatTheme(),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is ChatRoomMessageFetched) {
                    return BlocBuilder<SendChatMessageCubit,
                        SendChatMessageState>(
                      builder: (context, sendMessageState) {
                        return Chat(
                          messages: _messages,
                          onAttachmentPressed: _handleAttachmentPressed,
                          onMessageTap: _handleMessageTap,
                          onPreviewDataFetched: _handlePreviewDataFetched,
                          onSendPressed: _handleSendPressed,
                          showUserAvatars: true,
                          showUserNames: true,
                          user: _currentUser,
                          scrollPhysics: const BouncingScrollPhysics(),
                          //scrollController: _controller,
                          theme: const MyChatTheme(),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                }),
        ),
      ),
    );
  }

  /// to append an new message to the list
  void _addMessage(types.Message message, {bool sentByCurrentUser = false}) {
    //==> ImageMessage
    if (message is types.ImageMessage) {
      log("Image Message >> ${message.uri}");
      if (message.uri == AppUtils.undefined) {
        _setErrorOnSendingMessage();
      } else {
        insertNewMessage(message, sentByCurrentUser);
      }
    }

    //==> TextMessage
    else if (message is types.TextMessage) {
      log("Text Message >> ${message.text}");
      if (message.text == AppUtils.undefined) {
        _setErrorOnSendingMessage();
      } else {
        insertNewMessage(message, sentByCurrentUser);
      }
    }

    //==> else insert new message
    else {
      insertNewMessage(message, sentByCurrentUser);
    }
  }

  void _setErrorOnSendingMessage() {
    setState(() {
      _messages[0] = _messages[0].copyWith(status: types.Status.error);
    });
  }

  void insertNewMessage(types.Message message, bool sentByCurrentUser) {
    setState(() {
      if (sentByCurrentUser) {
        _messages[0] = _messages[0].copyWith(status: types.Status.seen);
      } else {
        _messages.insert(0, message);
      }
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.any,
    // );
    //
    // if (result != null && result.files.single.path != null) {
    //   final message = types.FileMessage(
    //     author: _user,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     id: const Uuid().v4(),
    //     mimeType: lookupMimeType(result.files.single.path!),
    //     name: result.files.single.name,
    //     size: result.files.single.size,
    //     uri: result.files.single.path!,
    //   );
    //
    //   _addMessage(message);
    // }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
        status: types.Status.sending,
      );

      _addMessage(message);
      _sendMessage(filePath: result.path);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    // if (message is types.FileMessage) {
    //   var localPath = message.uri;
    //
    //   if (message.uri.startsWith('http')) {
    //     try {
    //       final index =
    //       _messages.indexWhere((element) => element.id == message.id);
    //       final updatedMessage =
    //       (_messages[index] as types.FileMessage).copyWith(
    //         isLoading: true,
    //       );
    //
    //       setState(() {
    //         _messages[index] = updatedMessage;
    //       });
    //
    //       final client = http.Client();
    //       final request = await client.get(Uri.parse(message.uri));
    //       final bytes = request.bodyBytes;
    //       final documentsDir = (await getApplicationDocumentsDirectory()).path;
    //       localPath = '$documentsDir/${message.name}';
    //
    //       if (!File(localPath).existsSync()) {
    //         final file = File(localPath);
    //         await file.writeAsBytes(bytes);
    //       }
    //     } finally {
    //       final index =
    //       _messages.indexWhere((element) => element.id == message.id);
    //       final updatedMessage =
    //       (_messages[index] as types.FileMessage).copyWith(
    //         isLoading: null,
    //       );
    //
    //       setState(() {
    //         _messages[index] = updatedMessage;
    //       });
    //     }
    //   }
    //
    //   await OpenFilex.open(localPath);
    // }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  /// to handle on send  message pressed
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
      status: types.Status.sending,
    );

    //==> add message to ui
    _addMessage(textMessage);

    //==> send message to server
    _sendMessage(message: message.text);
  }

  /// load messages from server
  void _loadMessages() async {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _chatRoomCubit.fetchChatRoomMessages(chatId: chatRoomId, token: userToken);
  }

  /// to init current user data
  void _initCurrentUser() {
    final currentUser = widget.chatRoomArguments.authorizedUserEntity;
    _currentUser = types.User(
      id: currentUser.id.toString(),
      firstName: currentUser.firstName,
    );
  }

  /// send message to server
  void _sendMessage({String message = "", String filePath = ""}) {
    //==> init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _sendChatMessageCubit.sendTextMessage(
        chatId: chatRoomId,
        userToken: userToken,
        chatMessage: message,
        filePath: filePath);
  }

  /// to handle pusher state
  void _handleOtherPusherState(PusherState state) {
    /*
    *
    *
    * error after receiving an event
    *
    *
    * */
    if (state is ErrorWhileReceivingNewMessageState) {
      showSnackBar(
        context,
        message: "You have new message but something went wrong",
        backgroundColor: AppColor.accentColor,
        textColor: AppColor.primaryDarkColor,
      );
      _loadMessages();
    }

    /*
    *
    *
    * subscription error
    *
    *
    * */
    if (state is PusherSubscriptionErrorOccurred) {
      showSnackBar(
        context,
        message: "Error Occurred Chat will be saved",
        backgroundColor: AppColor.accentColor,
        textColor: AppColor.primaryDarkColor,
      );
    }

    /*
    *
    *
    * initialization error
    *
    *
    * */
    if (state is PusherInitializationErrorOccurred) {
      showSnackBar(
        context,
        message:
            "PusherInitializationErrorOccurred  Occurred Chat will be saved",
        backgroundColor: AppColor.accentColor,
        textColor: AppColor.primaryDarkColor,
      );
    }
  }
}
