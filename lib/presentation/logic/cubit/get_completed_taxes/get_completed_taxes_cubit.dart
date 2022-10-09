import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/tax_entity.dart';
import '../../../../domain/use_cases/taxes/get_completed_taxes.dart';

part 'get_completed_taxes_state.dart';

class GetCompletedTaxesCubit extends Cubit<GetCompletedTaxesState> {
  GetCompletedTaxesCubit() : super(GetCompletedTaxesInitial());

  void fetchCompletedTaxesList({required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetCompletedTaxesList());

    //==> init case
    final useCase = getItInstance<GetCompletedTaxesCase>();

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
          (appError) => _emitError(appError),
          (taxList) {
        if (taxList.isNotEmpty) {
          _emitIfNotClosed(
            CompletedTaxesListFetchedSuccessfully(taxList: taxList),
          );
        }
        // empty
        else {
          emit(EmptyCompletedTaxesList());
        }
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetCompletedTaxesList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetCompletedTaxesList());
    } else {
      _emitIfNotClosed(
          ErrorWhileGettingCompletedTaxesList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetCompletedTaxesState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
