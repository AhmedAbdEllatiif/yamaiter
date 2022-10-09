class CreateOrUpdateArticleRequestModel {
  final String title;
  final String description;
  final List<String> imageList;

  CreateOrUpdateArticleRequestModel({
    required this.title,
    required this.description,
    required this.imageList,
  });
}
