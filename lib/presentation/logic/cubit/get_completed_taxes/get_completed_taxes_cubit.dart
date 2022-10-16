import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/get_taxes_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/tax_entity.dart';
import '../../../../domain/use_cases/taxes/get_completed_taxes.dart';

part 'get_completed_taxes_state.dart';

class GetCompletedTaxesCubit extends Cubit<GetCompletedTaxesState> {
  GetCompletedTaxesCubit() : super(GetCompletedTaxesInitial());

  void fetchCompletedTaxesList(
      {required String userToken, required int offset}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetCompletedTaxesList());

    //==> init case
    final useCase = getItInstance<GetCompletedTaxesCase>();

    //==> init params
    final params = GetTaxesParams(userToken: userToken, offset: offset);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (taxList) {
        _emitIfNotClosed(_statusToEmit(taxList: taxList, offset: offset));
      },
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetCompletedTaxesState _statusToEmit(
      {required List<TaxEntity> taxList, required int offset}) {
    //==> last page reached
    if (offset > 0 && taxList.isEmpty) {
      return LastPageCompletedTaxesListFetched(taxList: taxList);
    }
    //==> empty list
    else if (taxList.isEmpty) {
      return EmptyCompletedTaxesList();
    }

    //==>  less than the limit
    else if (taxList.length < 10) {
      return LastPageCompletedTaxesListFetched(taxList: taxList);
    }

    //==> projects fetched
    else {
      return CompletedTaxesListFetchedSuccessfully(taxList: taxList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetCompletedTaxesList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetCompletedTaxesList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingCompletedTaxesList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetCompletedTaxesState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
