part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class RequestSendEmail extends ForgotPasswordEvent {
  final String email;
  RequestSendEmail(this.email);
}
