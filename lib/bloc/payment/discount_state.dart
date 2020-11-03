part of 'discount_bloc.dart';

@immutable
abstract class DiscountState {}

class DiscountInitial extends DiscountState {}

class ApplyingPromoCode extends DiscountState {}

class PromoCodeApplied extends DiscountState {
  final DiscountResponse discountResponse;
  PromoCodeApplied(this.discountResponse);
}

class PromoCodeRemoved extends DiscountState {}

class PromoCodeFailed extends DiscountState {}
