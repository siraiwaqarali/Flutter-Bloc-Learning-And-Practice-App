abstract class FormValidationEvent {}

class FormValidationTextChangedEvent extends FormValidationEvent {
  final String email;
  final String password;

  FormValidationTextChangedEvent({
    required this.email,
    required this.password,
  });
}

class FormValidationSubmitEvent extends FormValidationEvent {
  final String email;
  final String password;

  FormValidationSubmitEvent({
    required this.email,
    required this.password,
  });
}
