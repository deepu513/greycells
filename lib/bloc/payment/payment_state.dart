part of 'payment_bloc.dart';

@immutable
abstract class PaymentState {
  final Payment payment;

  const PaymentState(this.payment);
}

class PaymentInitial extends PaymentState {
  PaymentInitial(Payment payment) : super(payment);
}

class PaymentProcessing extends PaymentState {
  PaymentProcessing(Payment payment) : super(payment);
}

class PaymentSuccess extends PaymentState {
  PaymentSuccess() : super(null);
}

class PaymentFailure extends PaymentState {
  PaymentFailure() : super(null);
}

class PaymentStatusUnknown extends PaymentState {
  PaymentStatusUnknown() : super(null);
}
