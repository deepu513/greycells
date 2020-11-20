import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/repository/user_repository.dart';
import 'package:greycells/extensions.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  UserRepository _userRepository;

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is RequestSendEmail) {
      if (event.email.isNullOrEmpty()) {
        yield InvalidEmail();
      } else {
        try {
          yield SendingEmail();
          int statusCode =
              await _userRepository.resetPassword(email: event.email);
          if (statusCode == 200) {
            yield EmailSent();
          } else
            yield ForgotPasswordError(ErrorMessages.GENERIC_ERROR_MESSAGE);
        } catch (e) {
          debugPrint(e);
          if (e is ResourceNotFoundException) {
            yield ForgotPasswordError(Strings.forgotPasswordNotFound);
          }
          yield ForgotPasswordError(ErrorMessages.GENERIC_ERROR_MESSAGE);
        }
      }
    }
  }
}
