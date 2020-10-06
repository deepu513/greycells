part of 'payment_bloc.dart';

@immutable
abstract class PaymentState {
  final Payment payment;

  const PaymentState(this.payment);
}

class PaymentInitial extends PaymentState {
  PaymentInitial(Payment payment) : super(payment);
}

class ApplyingPromoCode extends PaymentState {
  ApplyingPromoCode(Payment payment) : super(payment);
}

class PromoCodeApplied extends PaymentState {
  PromoCodeApplied(Payment payment) : super(payment);
}

class PaymentProcessing extends PaymentState {
  PaymentProcessing(Payment payment) : super(payment);
}

class PaymentSuccess extends PaymentState {
  PaymentSuccess(Payment payment) : super(payment);
}

class PaymentFailure extends PaymentState {
  PaymentFailure(Payment payment) : super(payment);
}
