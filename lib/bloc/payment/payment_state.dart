part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentSuccessArgs paymentSuccessArgs;
  PaymentSuccess(this.paymentSuccessArgs);
}

class PaymentFailure extends PaymentState {}

class PaymentStatusUnknown extends PaymentState {
  final String paymentId;
  PaymentStatusUnknown(this.paymentId);
}
