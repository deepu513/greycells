import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/bloc/validation/validation_event.dart';
import 'package:greycells/bloc/validation/validation_state.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/user/user.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/repository/user_repository.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  LoginRequest loginRequest;
  UserRepository _userRepository;
  SettingsRepository _settingsRepository;

  bool shouldObscurePassword = true;

  final ValidationBloc validationBloc;
  StreamSubscription _validationSubscription;

  AuthenticationBloc(this.validationBloc)
      : assert(validationBloc != null),
        super(AuthenticationInitial()) {
    loginRequest = LoginRequest();
    _userRepository = UserRepository();
    _validationSubscription = validationBloc.listen((state) {
      if (state is LoginFieldsValid) {
        add(LoginInitiated(valid: true));
      }
    });
  }

  /// _settingsRepository is being initialized in each and every event here
  /// because, in real world, any event can occur and order is not guaranteed
  /// so to be safe, it is initialized inside every event. However, same
  /// instance will be retrieved once initialized because it is a singleton.
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticationLoading();
      _settingsRepository = await SettingsRepository.getInstance();

      if (_settingsRepository.get(SettingKey.KEY_IS_LOGGED_IN,
              defaultValue: false) &&
          _settingsRepository
              .get(SettingKey.KEY_REQUEST_TOKEN, defaultValue: "")
              .isNotEmpty) {
        yield AuthenticationAuthenticated();
      } else
        yield AuthenticationUnauthenticated();
    }

    if (event is LoginInitiated) {
      if (!event.valid) {
        validationBloc.add(ValidateLoginFields(loginRequest: loginRequest));
      } else if (event.valid) {
        yield AuthenticationLoading();

        try {
          User user =
              await _userRepository.authenticate(loginRequest: loginRequest);

          if (user != null) {
            _settingsRepository = await SettingsRepository.getInstance();
            await _settingsRepository.saveValue(
                SettingKey.KEY_IS_LOGGED_IN, true);
            await _saveUserDetails(user);
            yield AuthenticationAuthenticated();
          }

          /// This should never happen. Added for safety.
          else {
            yield AuthenticationFailure(
                error: ErrorMessages.GENERIC_ERROR_MESSAGE);
          }
        } catch (error) {
          if (error is ResourceNotFoundException)
            yield AuthenticationFailure(
                error: ErrorMessages.USER_NOT_FOUND_ERROR_MESSAGE);
          else
            yield AuthenticationFailure(error: error.toString());
        }
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      _settingsRepository = await SettingsRepository.getInstance();
      await _settingsRepository.saveValue(SettingKey.KEY_IS_LOGGED_IN, false);
      yield AuthenticationUnauthenticated();
    }

    if (event is TogglePasswordVisibility) {
      shouldObscurePassword = !shouldObscurePassword;
      yield PasswordVisibilityToggled();
    }
  }

  Future _saveUserDetails(User user) async {
    await _settingsRepository.saveValue(
        SettingKey.KEY_REQUEST_TOKEN, user.token);
    await _settingsRepository.saveValue(SettingKey.KEY_USER_ID, user.id);
    await _settingsRepository.saveValue(SettingKey.KEY_USERNAME, user.username);
    await _settingsRepository.saveValue(
        SettingKey.KEY_USER_FIRST_NAME, user.firstName);
    await _settingsRepository.saveValue(
        SettingKey.KEY_USER_MOBILE, user.mobileNumber);
  }

  @override
  Future<void> close() {
    _validationSubscription.cancel();
    validationBloc.close();
    return super.close();
  }
}
