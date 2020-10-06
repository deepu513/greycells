part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class ProcessPayment extends PaymentEvent {}

class PaymentUpdated extends PaymentEvent {
  final Payment updatedPayment;

  PaymentUpdated(this.updatedPayment);
}
