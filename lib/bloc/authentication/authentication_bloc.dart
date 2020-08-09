import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/bloc/validation/validation_bloc.dart';
import 'package:mental_health/bloc/validation/validation_event.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/constants/setting_key.dart';
import 'package:mental_health/networking/http_exceptions.dart';
import 'package:mental_health/repository/settings/settings_repository.dart';
import 'package:mental_health/repository/user/user_repository.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository _userRepository;
  SettingsRepository _settingsRepository;

  final ValidationBloc validationBloc;
  StreamSubscription _validationSubscription;

  AuthenticationBloc(this.validationBloc) : assert(validationBloc != null) {
    _userRepository = UserRepository();
    _validationSubscription = validationBloc.listen((state) {
      if (state is ValidationLoginFieldsValid) {
        add(LoginInitiated(loginRequest: state.loginRequest, valid: true));
      }
    });
  }

  @override
  AuthenticationState get initialState => AuthenticationInitial();

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
          defaultValue: false)) {
        var userId =
            _settingsRepository.get(SettingKey.KEY_USER_ID, defaultValue: -1);

        if (userId != -1) {
          User user = await _userRepository.get(userId);
          if (user != null)
            yield AuthenticationAuthenticated(user);

          /// This should never happen. Added for safety.
          else {
            yield AuthenticationFailure(
                error: "Something went wrong! Please try again.");
          }
        }

        /// This should never happen. Added for safety.
        else {
          yield AuthenticationFailure(
              error: "Something went wrong! Please try again.");
        }
      } else
        yield AuthenticationUnauthenticated();
    }

    if (event is LoginInitiated) {
      if (!event.valid) {
        validationBloc.add(ValidationValidateLoginFields(
            loginRequest: event.loginRequest));
      } else if (event.valid) {
        yield AuthenticationLoading();

        try {
          User user = await _userRepository.authenticate(
              loginRequest: event.loginRequest);

          if (user != null) {
            _settingsRepository = await SettingsRepository.getInstance();
            await _settingsRepository.saveValue(
                SettingKey.KEY_IS_LOGGED_IN, true);
            yield AuthenticationAuthenticated(user);
          }

          /// This should never happen. Added for safety.
          else {
            yield AuthenticationFailure(
                error: "Something went wrong! Please try again.");
          }
        } on ResourceNotFoundException {
          yield AuthenticationUserNotFound();
        } catch (error) {
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
  }

  @override
  Future<void> close() {
    _validationSubscription.cancel();
    validationBloc.close();
    return super.close();
  }
}
