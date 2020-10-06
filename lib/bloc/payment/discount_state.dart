part of 'discount_bloc.dart';

@immutable
abstract class DiscountState {}

class DiscountInitial extends DiscountState {}

class ApplyingPromoCode extends DiscountState {}

class PromoCodeApplied extends DiscountState {
  final Payment updatedPayment;

  PromoCodeApplied(this.updatedPayment);
}

class PromoCodeRemoved extends DiscountState {
  final Payment updatedPayment;

  PromoCodeRemoved(this.updatedPayment);
}

class PromoCodeFailed extends DiscountState {}
