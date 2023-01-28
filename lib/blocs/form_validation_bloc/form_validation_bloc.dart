import 'package:blocapp/blocs/form_validation_bloc/form_validation_event.dart';
import 'package:blocapp/blocs/form_validation_bloc/form_validation_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(FormValidationInitialState()) {
    on<FormValidationTextChangedEvent>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        emit(FormValidationErrorState(
            error: 'Please enter a valid email adddress.'));
      } else if (event.password.length < 8) {
        emit(FormValidationErrorState(
            error: 'Password must be at least 8 characters long.'));
      } else {
        emit(FormValidationValidState());
      }
    });
    on<FormValidationSubmitEvent>((event, emit) {
      emit(FormValidationLoadingState());
    });
  }
}
