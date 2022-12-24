import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/tax/tax_request_model.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/create_tax_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/taxes/pay_for_tax.dart';

part 'pay_for_tax_state.dart';

class PayForTaxCubit extends Cubit<PayForTaxState> {
  PayForTaxCubit() : super(CreateTaxInitial());

  /// to create Tax
  void createTax(
      {required String taxName,
      required String taxPassword,
      required String taxFile,
      required String note,
      required double value,
      required String token}) async {
    //==> loTaxing
    _emitIfNotClosed(LoadingCreateTax());

    //==> init case
    final useCase = getItInstance<PayForTaxCase>();

    //==> init params
    final params = CreateTaxParams(
      createTaxRequestModel: CreateTaxRequestModel(
        taxName: taxName,
        taxPassword: taxPassword,
        value: value,
        taxFile: taxFile,
        description: note,
      ),
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (payEntity) => _emitIfNotClosed(
              TaxCreatedSuccessfully(payEntity: payEntity),
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
  void _emitIfNotClosed(PayForTaxState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
