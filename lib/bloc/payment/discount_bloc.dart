import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/repository/payment_repository.dart';
import 'package:greycells/models/payment/discount_request.dart';
import 'package:greycells/models/payment/discount_response.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:meta/meta.dart';
import 'package:greycells/extensions.dart';

part 'discount_event.dart';

part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  PaymentRepository _paymentRepository;
  SettingsRepository _settingsRepository;

  DiscountBloc() : super(DiscountInitial()) {
    _paymentRepository = PaymentRepository();
    SettingsRepository.getInstance()
        .then((value) => _settingsRepository = value);
  }

  @override
  Stream<DiscountState> mapEventToState(
    DiscountEvent event,
  ) async* {
    if (event is ApplyPromoCode) {
      if (event.promoCode.isNullOrEmpty()) {
        yield PromoCodeFailed();
      } else {
        yield ApplyingPromoCode();
        try {
          DiscountRequest discountRequest = DiscountRequest();
          discountRequest.promoCode = event.promoCode;
          discountRequest.userId =
              _settingsRepository.get(SettingKey.KEY_USER_ID);
          DiscountResponse response =
              await _paymentRepository.requestDiscount(discountRequest);
          if (response != null && response.result == true) {
            yield PromoCodeApplied(response);
          } else
            yield PromoCodeFailed();
        } catch (e) {
          print(e);
          yield PromoCodeFailed();
        }
      }
    }

    if (event is RemovePromoCode) {
      yield PromoCodeRemoved();
    }
  }
}
