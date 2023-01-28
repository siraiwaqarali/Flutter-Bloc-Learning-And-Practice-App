abstract class FormValidationState {}

class FormValidationInitialState extends FormValidationState {}

class FormValidationInvalidState extends FormValidationState {}

class FormValidationValidState extends FormValidationState {}

class FormValidationErrorState extends FormValidationState {
  final String error;
  FormValidationErrorState({required this.error});
}

class FormValidationLoadingState extends FormValidationState {}
