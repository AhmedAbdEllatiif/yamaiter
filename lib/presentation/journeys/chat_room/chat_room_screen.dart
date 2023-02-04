import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:open_filex/open_filex.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/journeys/chat_room/chat_room_bottom_sheet/chat_room_bottom_sheet.dart';
import 'package:yamaiter/presentation/logic/common/chat_room/chat_room_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/pusher/pusher_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/send_chat_message/send_chat_message_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/classes/file_downloader.dart';
import '../../../common/pickers/file_picker/my_file_picker.dart';
import '../../../common/pickers/file_picker/my_file_picker_state.dart';
import '../../../common/pickers/image_picker/my_image_picker.dart';
import '../../../common/pickers/image_picker/my_image_picker_state.dart';
import '../../../domain/entities/screen_arguments/chat_room_args.dart';
import '../../../router/route_helper.dart';
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
        _fetchChatRoomMessages();
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
    _fetchChatRoomMessages();
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
            _handleReceivedPusherState(state);
          },

          // error if chat room == -1
          child: chatRoomId == -1
              ? Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unHandledError,
                    onPressedRetry: () {
                      _fetchChatRoomMessages();
                    },
                  ),
                )
              : BlocConsumer<ChatRoomCubit, ChatRoomState>(
                  //==> ChatRoomCubit listener
                  listener: (context, state) {
                    if (state is ChatRoomMessageFetched) {
                      _addAllReceivedMessage(state.messages);
                    }
                  },
                  //==> ChatRoomCubit builder
                  builder: (context, state) {
                    /*
                    *
                    * error while fetching messages
                    *
                    * */
                    if (state is ErrorWhileFetchingChatRoomMessages) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: state.appError.appErrorType,
                          onPressedRetry: () {
                            _fetchChatRoomMessages();
                          },
                        ),
                      );
                    }

                    /*
                  *
                  * unAuthorized to fetch chat room messages
                  *
                  * */
                    if (state is UnAuthorizedToFetchChatRoomMessages) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: AppErrorType.unauthorizedUser,
                          buttonText: "تسجيل الدخول",
                          onPressedRetry: () {
                            _navigateToLogin();
                          },
                        ),
                      );
                    }

                    /*
                    *
                    * loading and the _messages is empty
                    *
                    * */
                    if (state is LoadingChatRoomMessages && _messages.isEmpty) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    /*
                  *
                  *
                  *
                  * loading and the _messages is not empty
                  * this case occurs when we receive an error from pusher
                  * so we need to fetch messages from the server
                  * to update the ui
                  * Upon this case Show loading with messages
                  *
                  *
                  * */
                    if (state is LoadingChatRoomMessages &&
                        _messages.isNotEmpty) {
                      return Column(
                        children: [
                          const LoadingWidget(),
                          Expanded(
                            child: Chat(
                              messages: _messages,
                              onAttachmentPressed:
                                  _handleAddNewAttachmentPressed,
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

                    /*
                    *
                    * messages fetched
                    *
                    * */
                    if (state is ChatRoomMessageFetched) {
                      return BlocBuilder<SendChatMessageCubit,
                          SendChatMessageState>(
                        builder: (context, sendMessageState) {
                          return Chat(
                            messages: _messages,
                            onAttachmentPressed: _handleAddNewAttachmentPressed,
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

                    /*
                  *
                  * other cases
                  *
                  * */
                    return const SizedBox.shrink();
                  },
                ),
        ),
      ),
    );
  }

  /// to handle pusher state
  void _handleReceivedPusherState(PusherState state) {
    /*
    *
    *
    * new message received
    *
    *
    * */
    if (state is PusherNewMessageReceived) {
      final messageUserId = state.message.author.id;

      _addMessageToUiList(
        state.message,
        sentByCurrentUser: messageUserId == _currentUser.id,
      );
    }

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
      _fetchChatRoomMessages();
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

  /// add all received message to the ui list
  void _addAllReceivedMessage(List<types.Message> messages) {
    _messages = messages;
  }

  /// to append an new message to the list
  void _addMessageToUiList(
    types.Message message, {
    bool sentByCurrentUser = false,
  }) {
    // message has error
    bool messageHasError = false;

    //==> TextMessage
    if (message is types.TextMessage) {
      if (message.text == AppUtils.undefined) {
        messageHasError = true;
      }
    }

    //==> ImageMessage
    else if (message is types.ImageMessage) {
      if (message.uri == AppUtils.undefined) {
        messageHasError = true;
      }
    }

    //==> FileMessage
    else if (message is types.FileMessage) {
      if (message.uri == AppUtils.undefined) {
        messageHasError = true;
      }
    }

    //==> update the ui
    setState(() {
      // update sent message status with error
      if (messageHasError) {
        _messages[0] = _messages[0].copyWith(status: types.Status.error);
      }

      // if me just update the message status to seen
      else if (sentByCurrentUser) {
        _messages[0] = _messages[0].copyWith(status: types.Status.seen);
      }
      // not me >> insert message without updating status to the list
      else {
        _messages.insert(0, message);
      }
    });
  }

  /// handle on add attachment pressed
  void _handleAddNewAttachmentPressed() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColor.primaryDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppUtils.cornerRadius.w),
            topLeft: Radius.circular(AppUtils.cornerRadius.w),
          ),
        ),
        builder: (BuildContext context) {
          return ChatRoomBottomSheet(
            // onSelectImagePressed
            onSelectImagePressed: () {
              Navigator.pop(context);
              _handleImageSelection();
            },

            // onSelectFilePressed
            onSelectFilePressed: () {
              Navigator.pop(context);
              _handleFileSelection();
            },

            // onSelectFilePressed
            onCancelPressed: () => Navigator.pop(context),
          );
        });
  }

  /// handle file selection
  void _handleFileSelection() async {
    // pick new file
    final myFilePicker = MyFilePicker(maxFileSize: 3145728);
    final state = await myFilePicker.selectNewFile();

    /*
    *
    * MaxFileSizeReached
    * */
    if (state is MaxFileSizeReached) {
      _showErrorWithSnackBar("اقصى حجم ملف هو ${state.maxSizeToSelect} ");
    }

    /*
    *
    * ErrorWhilePickingFile
    * */
    if (state is ErrorWhilePickingFile) {
      _showErrorWithSnackBar("حدث خطأ اعد الحاولة لاحقا");
    }

    /*
    *
    * NoFileSelected
    * */
    if (state is NoFileSelected) {
      log("ChatRoomScreen >> _handleFileSelection() >> NoFileSelected");
    }

    /*
    *
    * Success
    * */
    if (state is FilePickedSuccessfully) {
      final file = state.selectedFile;

      //==> init FileMessage
      final message = types.FileMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        //mimeType: lookupMimeType(result.files.single.path!),
        name: file.name,
        size: file.size,
        uri: file.path!,
        status: types.Status.sending,
      );

      //==> add message to ui
      _addMessageToUiList(message);

      //==> send message
      _sendMessageToServer(filePath: file.path!);
    }
  }

  /// handle image selection
  void _handleImageSelection() async {
    // pick new image
    final myImagePicker = MyImagePicker(maxImageSize: 3145728);
    final state = await myImagePicker.selectNewImage();

    /*
    *
    * MaxImageSizeReached
    * */
    if (state is MaxImageSizeReached) {
      _showErrorWithSnackBar("اقصى حجم صورة هو ${state.maxSizeToSelect} ");
    }

    /*
    *
    * ErrorWhilePickingImage
    * */
    if (state is ErrorWhilePickingImage) {
      _showErrorWithSnackBar("حدث خطأ اعد الحاولة لاحقا");
    }

    /*
    *
    * NoImageSelected
    * */
    if (state is NoImageSelected) {
      log("ChatRoomScreen >> _handleFileSelection() >> NoFileSelected");
    }

    /*
    *
    * Success
    * */
    if (state is ImagePickedSuccessfully) {
      final image = state.selectedImage;
      final imageName = state.imageName;
      final imageSize = state.imageSize;
      final imagePath = state.imagePath;

      //==> init FileMessage
      final message = types.ImageMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: imageName,
        size: imageSize,
        uri: imagePath,
        width: image.width.toDouble(),
        status: types.Status.sending,
      );

      //==> add message to ui
      _addMessageToUiList(message);

      //==> send message
      _sendMessageToServer(filePath: imagePath);
    }
  }

  /// handle on message tapped
  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      //==> try to download the file
      try {
        _showOrHideLoadingFileMessage(
          messageId: message.id,
          showLoading: true,
        );

        final fileDownloader = FileDownloader(
          fileUrl: message.uri,
          fileName: message.name,
        );

        localPath = await fileDownloader.getLocalFilePath();
      }

      //==> catch errors
      catch (e) {
        _showErrorWithSnackBar("حدث خطأ اعد الحاولة لاحقا");
        log("ChatRoom >> _handleMessageTap >> error: $e");
      }

      //==> finally hide loading
       finally {
        _showOrHideLoadingFileMessage(
            messageId: message.id, showLoading: false);
      }

      //==> open file
      await OpenFilex.open(localPath);
    }
  }

  /// to show or hide loading while opening a file
  void _showOrHideLoadingFileMessage({
    required String messageId,
    required bool showLoading,
  }) {
    try {
      //==> update message view with loading
      final index = _messages.indexWhere((element) => element.id == messageId);
      final updatedMessage = (_messages[index] as types.FileMessage).copyWith(
        isLoading: showLoading ? true : null,
      );

      setState(() {
        _messages[index] = updatedMessage;
      });
    } catch (e) {
      log("ChatRoomScreen >> _showOrHideLoadingFileMessage() >> Error: $e");
    }
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
    _addMessageToUiList(textMessage);

    //==> send message to server
    _sendMessageToServer(message: message.text);
  }

  /// load messages from server
  void _fetchChatRoomMessages() async {
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
  void _sendMessageToServer({String message = "", String filePath = ""}) {
    //==> init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _sendChatMessageCubit.sendTextMessage(
        chatId: chatRoomId,
        userToken: userToken,
        chatMessage: message,
        filePath: filePath);
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

  /// to show snackBar error
  void _showErrorWithSnackBar(String message) {
    showSnackBar(context,
        message: message, backgroundColor: AppColor.accentColor);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);
}
