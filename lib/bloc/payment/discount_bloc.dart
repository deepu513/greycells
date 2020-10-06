import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:meta/meta.dart';

part 'discount_event.dart';

part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  String promoCode;

  DiscountBloc() : super(DiscountInitial()) {
    promoCode = "";
  }

  @override
  Stream<DiscountState> mapEventToState(
    DiscountEvent event,
  ) async* {
    if (event is ApplyPromoCode) {
      yield ApplyingPromoCode();
      //event.payment;
      // TODO: Make api call for promo code
      // update this.discountAmount, this.updatedTotalAmount
      //yield PromoCodeApplied();
    }

    if (event is RemovePromoCode) {
      // TODO: update payment
      //yield PromoCodeRemoved(updatedPayment);
    }
  }
}
