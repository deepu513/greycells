import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mental_health/bloc/validation/bloc.dart';

abstract class Validatable {
  /// Invoked when parent widget requests for validation.
  /// returns validation result as boolean response
  FutureOr<bool> validate(BuildContext context, ValidationBloc validationBloc);
}