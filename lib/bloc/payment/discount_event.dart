part of 'discount_bloc.dart';

@immutable
abstract class DiscountEvent {}

class ApplyPromoCode extends DiscountEvent {
  final Payment payment;

  ApplyPromoCode(this.payment);
}

class RemovePromoCode extends DiscountEvent {}
