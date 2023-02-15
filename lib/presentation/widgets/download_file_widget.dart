import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/rounded_text.dart';

import '../../common/classes/file_downloader.dart';
import '../../common/constants/sizes.dart';
import '../../common/functions/common_functions.dart';
import '../themes/theme_color.dart';

class DownloadFileWidget extends StatefulWidget {
  final String text;
  final String fileName;
  final String fileUrl;

  const DownloadFileWidget(
      {Key? key,
      this.text = "ملف المهمة",
      required this.fileName,
      required this.fileUrl})
      : super(key: key);

  @override
  State<DownloadFileWidget> createState() => _DownloadFileWidgetState();
}

class _DownloadFileWidgetState extends State<DownloadFileWidget> {
  late final String _fileName;
  late final String _fileUrl;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fileName = widget.fileName;
    _fileUrl = widget.fileUrl;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: LoadingWidget(
              size: 60,
            ),
          )
        : RoundedText(
            text: widget.text,
            rightIconData: Icons.file_copy_rounded,
            textSize: Sizes.dimen_10,
            onPressed: () => _openFile(),
          );
  }

  /// to down and open file
  void _openFile() async {
    var localPath = _fileUrl;
    _toggleLoading(true);
    //==> try to download the file
    try {
      final fileDownloader = FileDownloader(
        fileUrl: _fileUrl,
        fileName: _fileName,
      );

      localPath = await fileDownloader.getLocalFilePath();
    }

    //==> catch errors
    catch (e) {
      _showErrorWithSnackBar("حدث خطأ اعد الحاولة لاحقا");
      log("DownloadFileWidget >> _handleMessageTap >> error: $e");
    }

    //==> finally hide loading
     finally {
      _toggleLoading(false);
    }

    //==> open file
    await OpenFilex.open(localPath);
  }

  /// to change loading view
  void _toggleLoading(bool showLoading) {
    setState(() {
      isLoading = showLoading;
    });
  }

  /// to show snackBar error
  void _showErrorWithSnackBar(String message) {
    showSnackBar(context,
        message: message, backgroundColor: AppColor.accentColor);
  }
}
