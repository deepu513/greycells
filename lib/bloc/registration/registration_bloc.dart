import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/bloc/validation/validation_bloc.dart';
import 'package:mental_health/bloc/validation/validation_event.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/constants/setting_key.dart';
import 'package:mental_health/models/registration/registration.dart';
import 'package:mental_health/repository/settings/settings_repository.dart';
import 'package:mental_health/repository/user/user_repository.dart';

import './bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  Registration registration;
  UserRepository _userRepository;
  SettingsRepository _settingsRepository;

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
        validationBloc.add(
            ValidateRegistrationFields(registration: registration));
      else if (event.validated) {
        yield RegistrationInProgress();

        try {
          /*User user = await _userRepository.post(event.user);
          if (user != null) {*/
          _settingsRepository = await SettingsRepository.getInstance();
          await _settingsRepository.saveValue(
              SettingKey.KEY_IS_LOGGED_IN, true);
          yield RegistrationSuccessful(/*user: user*/);
          //}
        } catch (error) {
          yield RegistrationUnsuccessful(error: error.toString());
        }
      }
    }
  }

  @override
  Future<void> close() {
    _validationSubscription.cancel();
    validationBloc.close();
    return super.close();
  }
}
