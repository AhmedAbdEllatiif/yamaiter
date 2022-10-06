class CreateArticleRequestModel {
  final String title;
  final String description;
  final List<String> imageList;

  CreateArticleRequestModel({
    required this.title,
    required this.description,
    required this.imageList,
  });
}
