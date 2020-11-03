import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/payment/order_create.dart';
import 'package:greycells/models/payment/order_create_response.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/models/payment/payment_verify.dart';
import 'package:greycells/models/payment/payment_verify_response.dart';
import 'package:greycells/repository/payment_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  int _paymentDiscountId;
  Razorpay _razorPay;
  PaymentRepository _paymentRepository;
  SettingsRepository _settingsRepository;

  PaymentBloc() : super(PaymentInitial()) {
    _razorPay = Razorpay();
    _paymentRepository = PaymentRepository();
    SettingsRepository.getInstance()
        .then((value) => _settingsRepository = value);

    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is ProcessPayment) {
      yield PaymentProcessing();
      try {
        OrderCreate orderCreate = OrderCreate();
        orderCreate.amount = event.payment.totalAmount;
        orderCreate.userId = _settingsRepository.get(SettingKey.KEY_USER_ID);
        orderCreate.type = event.payment.type;
        OrderCreateResponse response =
            await _paymentRepository.createOrder(orderCreate);
        if (response != null && response.result == true) {
          var options = {
            'key': 'rzp_test_KkImIAxTZ6MuDH',
            'amount': int.parse(response.razorPayAmount),
            'name': 'Greycells Wellness',
            'order_id': response.orderId,
            'description': event.payment.type == PaymentType.APPOINTMENT
                ? "Appointment with therapist"
                : "Assessment test",
            'timeout': 300, // in seconds
          };
          _paymentDiscountId = event.payment.discountId;
          _razorPay.open(options);
        } else {
          yield PaymentFailure();
        }
      } catch (e) {
        print(e);
        yield PaymentFailure();
      }
    }

    if (event is VerifyPayment) {
      try {
        PaymentVerify verify = PaymentVerify();
        verify.userId = _settingsRepository.get(SettingKey.KEY_USER_ID);
        verify.razorPayOrderId = event.orderId;
        verify.razorPayPaymentId = event.paymentId;
        verify.razorPaySignature = event.signature;
        verify.discountId = _paymentDiscountId ?? 0;

        PaymentVerifyResponse response =
            await _paymentRepository.verifyPayment(verify);
        if (response != null && response.result == true) {
          yield PaymentSuccess();
        } else
          yield PaymentStatusUnknown();
      } catch (e) {
        print(e);
        yield PaymentStatusUnknown();
      }
    }

    if (event is FailPayment) {
      yield PaymentFailure();
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    add(VerifyPayment(
        response.orderId, response.paymentId, response.signature));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    add(FailPayment());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Future<void> close() {
    _razorPay.clear();
    return super.close();
  }
}
