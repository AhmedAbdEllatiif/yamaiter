import 'package:equatable/equatable.dart';

class HelpQuestionEntity
    extends Equatable {
  final int id;
  final String title;
  final List<QuestionEntity> questions;

  const HelpQuestionEntity
      ({
    required this.id,
    required this.title,
    required this.questions,
  });


  @override
  List<Object?> get props => [id];
}



class QuestionEntity extends Equatable {
  final int id;
  final String title;
  final String answer;

  const QuestionEntity({
    required this.id,
    required this.title,
    required this.answer,
  });

  @override
  List<Object?> get props => [id];
}
