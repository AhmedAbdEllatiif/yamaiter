import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/get_taxes_params.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/domain/use_cases/taxes/get_in_progress_taxes.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_in_progress_taxes_state.dart';

class GetInProgressTaxesCubit extends Cubit<GetInProgressTaxesState> {
  GetInProgressTaxesCubit() : super(GetInProgressTaxesInitial());

  void fetchInProgressTaxesList(
      {required String userToken, required int offset}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetInProgressTaxesList());

    //==> init case
    final useCase = getItInstance<GetInProgressTaxesCase>();

    //==> init params
    final params = GetTaxesParams(userToken: userToken, offset: offset);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (taxList) {
        _emitIfNotClosed(
          _statusToEmit(taxList: taxList, offset: offset),
        );
      },
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetInProgressTaxesState _statusToEmit(
      {required List<TaxEntity> taxList, required int offset}) {
    print("Here to emit, Length: ${taxList.length}");
    //==> last page reached
    if (offset > 0 && taxList.isEmpty) {
      return LastPageInProgressTaxesListFetched(taxList: taxList);
    }
    //==> empty list
    else if (taxList.isEmpty) {
      return EmptyInProgressTaxesList();
    }

    //==>  less than the limit
    else if (taxList.length < 10) {
      return LastPageInProgressTaxesListFetched(taxList: taxList);
    }

    //==> projects fetched
    else {
      return InProgressTaxesListFetchedSuccessfully(taxList: taxList);
    }
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
