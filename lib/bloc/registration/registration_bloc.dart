import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/bloc/validation/validation_event.dart';
import 'package:greycells/bloc/validation/validation_state.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/registration/registration.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/repository/settings/settings_repository.dart';
import 'package:greycells/repository/user/user_repository.dart';

import './bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  Registration registration;
  UserRepository _userRepository;
  SettingsRepository _settingsRepository;

  bool shouldObscurePassword = true;
  bool shouldObscureConfirmPassword = true;

  final ValidationBloc validationBloc;
  StreamSubscription _validationSubscription;

  RegistrationBloc(this.validationBloc)
      : assert(validationBloc != null),
        super(RegistrationStateInitial()) {
    registration = Registration();
    _userRepository = UserRepository();
    _validationSubscription = validationBloc.listen((state) {
      if (state is RegistrationFieldsValid) {
        add(RegistrationCreateUser(validated: true));
      }
    });
  }

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationCreateUser) {
      if (!event.validated)
        validationBloc
            .add(ValidateRegistrationFields(registration: registration));
      else if (event.validated) {
        yield RegistrationInProgress();

        try {
          bool success =
              await _userRepository.register(registration: registration);
          if (success != null && success == true) {
            _settingsRepository = await SettingsRepository.getInstance();
            await _settingsRepository.saveValue(
                SettingKey.KEY_IS_LOGGED_IN, true);
            yield RegistrationSuccessful();
          }
        } catch (error) {
          if (error is ResourceConflictException)
            yield RegistrationUnsuccessful(
                error: ErrorMessages.USER_REGISTERED_ERROR_MESSAGE);
          else
            yield RegistrationUnsuccessful(error: error.toString());
        }
      }
    }

    if (event is TogglePasswordVisibility) {
      shouldObscurePassword = !shouldObscurePassword;
      yield PasswordVisibilityToggled();
    }

    if (event is ToggleConfirmPasswordVisibility) {
      shouldObscureConfirmPassword = !shouldObscureConfirmPassword;
      yield ConfirmPasswordVisibilityToggled();
    }
  }

  @override
  Future<void> close() {
    _validationSubscription.cancel();
    validationBloc.close();
    return super.close();
  }
}
