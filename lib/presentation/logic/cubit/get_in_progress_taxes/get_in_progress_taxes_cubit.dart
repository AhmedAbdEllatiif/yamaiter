import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/domain/use_cases/taxes/get_in_progress_taxes.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_in_progress_taxes_state.dart';

class GetInProgressTaxesCubit extends Cubit<GetInProgressTaxesState> {
  GetInProgressTaxesCubit() : super(GetInProgressTaxesInitial());

  void fetchInProgressTaxesList({required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetInProgressTaxesList());

    //==> init case
    final useCase = getItInstance<GetInProgressTaxesCase>();

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (taxList) {
        if (taxList.isNotEmpty) {
          _emitIfNotClosed(
            InProgressTaxesListFetchedSuccessfully(taxList: taxList),
          );
        }
        // empty
        else {
          emit(EmptyInProgressTaxesList());
        }
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetInProgressTaxesList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetInProgressTaxesList());
    } else {
      _emitIfNotClosed(
          ErrorWhileGettingInProgressTaxesList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetInProgressTaxesState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
