part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class ApplyPromoCode extends PaymentEvent {}

class ProcessPayment extends PaymentEvent {}
