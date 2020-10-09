import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/repository/payment_repository.dart';
import 'package:greycells/models/payment/discount_request.dart';
import 'package:greycells/models/payment/discount_response.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:meta/meta.dart';

part 'discount_event.dart';

part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  String promoCode;
  PaymentRepository _paymentRepository;
  SettingsRepository _settingsRepository;


  DiscountBloc() : super(DiscountInitial()) {
    promoCode = "";
    _paymentRepository = PaymentRepository();
    SettingsRepository.getInstance()
        .then((value) => _settingsRepository = value);
  }

  @override
  Stream<DiscountState> mapEventToState(DiscountEvent event,) async* {
    if (event is ApplyPromoCode) {
      yield ApplyingPromoCode();
      try {
        DiscountRequest discountRequest = DiscountRequest();
        discountRequest.promoCode = promoCode;
        discountRequest.userId =
            _settingsRepository.get(SettingKey.KEY_USER_ID);
        DiscountResponse response = await _paymentRepository.requestDiscount(
            discountRequest);
        if (response != null && response.result == true) {
          event.payment.discountId = response.discountId;
          event.payment.discountAmount =
              ((response.discountPercent / 100) * event.payment.originalAmount)
                  .floor();
          event.payment.totalAmount =
              event.payment.originalAmount - event.payment.discountAmount;
          event.payment.promoCodeApplied = true;

          yield PromoCodeApplied(event.payment);
        } else
          yield PromoCodeFailed();
      } catch (e) {
        print(e);
        yield PromoCodeFailed();
      }
    }

    if (event is RemovePromoCode) {
      event.payment.promoCodeApplied = false;
      event.payment.totalAmount = event.payment.originalAmount;
      event.payment.discountAmount = 0;
      event.payment.discountId = 0;
      yield PromoCodeRemoved(event.payment);
    }
  }
}
