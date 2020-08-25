import 'dart:async';

abstract class Validatable {
  /// Invoked when parent widget requests for validation.
  /// returns validation result as boolean response
  FutureOr<bool> validate();
}