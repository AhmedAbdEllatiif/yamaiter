import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_article_state.dart';

class UpdateArticleCubit extends Cubit<UpdateArticleState> {
  UpdateArticleCubit() : super(UpdateArticleInitial());
}
