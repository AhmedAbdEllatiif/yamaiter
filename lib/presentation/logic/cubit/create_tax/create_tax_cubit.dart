import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/tax/tax_request_model.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/create_tax_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/create_tax.dart';

part 'create_tax_state.dart';

class CreateTaxCubit extends Cubit<CreateTaxState> {
  CreateTaxCubit() : super(CreateTaxInitial());

  /// to create Tax
  void createTax(
      {required String taxName,
      required String taxPassword,
      required String taxFile,
      required String note,
      required String token}) async {
    //==> loTaxing
    _emitIfNotClosed(LoadingCreateTax());

    //==> init case
    final createTaxCase = getItInstance<CreateTaxCase>();

    //==> init params
    final params = CreateTaxParams(
        createTaxRequestModel: CreateTaxRequestModel(
          taxName: taxName,
          taxPassword: taxPassword,
          taxFile: taxFile,
          note: note,
        ),
        userToken: token);

    //==> send request
    final either = await createTaxCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaxCreatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateTax());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateTax());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingTax(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateTaxState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
