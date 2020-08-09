import 'package:mental_health/bloc/validation/bloc.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';

extension Validation on ValidationState {
  bool isFieldInvalid(ValidationField field) => this is ValidationInvalidField &&
        (this as ValidationInvalidField).field == field;
}
