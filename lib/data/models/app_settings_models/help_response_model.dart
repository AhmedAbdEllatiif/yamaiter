import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/help_question_entity.dart';

///  return a list of terms and conditions models
List<HelpResponseModel> listOfHelpQuestionModel(dynamic data) =>
    List<HelpResponseModel>.from(
      data.map(
        (x) => HelpResponseModel.fromJson(x),
      ),
    );

/// HelpResponseModel
class HelpResponseModel extends HelpQuestionEntity {
  const HelpResponseModel({
    required this.helpId,
    required this.helpTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.helpQuestions,
  }) : super(
          id: helpId,
          title: helpTitle,
          questions: helpQuestions,
        );

  final int helpId;
  final String helpTitle;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<HelpQuestionModel> helpQuestions;

  factory HelpResponseModel.fromJson(Map<String, dynamic> json) =>
      HelpResponseModel(
        helpId: json["id"] ?? -1,
        helpTitle: json["title"] ?? AppUtils.undefined,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
        helpQuestions: json["faqs"] != null
            ? List<HelpQuestionModel>.from(
                json["faqs"].map((x) => HelpQuestionModel.fromJson(x)))
            : [],
      );
}

/// Question model
class HelpQuestionModel extends QuestionEntity {
  const HelpQuestionModel({
    required this.questionId,
    required this.questionTitle,
    required this.questionAnswer,
    required this.pageId,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: questionId, title: questionTitle, answer: questionAnswer);

  final int questionId;
  final String questionTitle;
  final String questionAnswer;
  final int pageId;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory HelpQuestionModel.fromJson(Map<String, dynamic> json) =>
      HelpQuestionModel(
        questionId: json["id"] ?? -1,
        questionTitle: json["question"] ?? AppUtils.undefined,
        questionAnswer: json["answer"] ?? AppUtils.undefined,
        pageId: json["page_id"] ?? -1,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
      );
}
