part of 'discount_bloc.dart';

@immutable
abstract class DiscountEvent {}

class ApplyPromoCode extends DiscountEvent {
  final String promoCode;

  ApplyPromoCode(this.promoCode);
}

class RemovePromoCode extends DiscountEvent {}
