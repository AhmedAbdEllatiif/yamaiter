class UploadTaskFileParams {
  final int taskId;
  final String userToken;
  final List<String> files;

  UploadTaskFileParams({
    required this.taskId,
    required this.userToken,
    required this.files,
  });
}
