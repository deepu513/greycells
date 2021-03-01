part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class ProcessPayment extends PaymentEvent {
  final Payment payment;
  final String key;

  ProcessPayment(this.payment, this.key);
}

class VerifyPayment extends PaymentEvent {
  final String orderId;
  final String paymentId;
  final String signature;

  VerifyPayment(this.orderId, this.paymentId, this.signature);
}

class FailPayment extends PaymentEvent {}
