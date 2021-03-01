import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/local_notifications.dart';
import 'package:greycells/models/appointment/create_appointment_request.dart';
import 'package:greycells/models/payment/order_create.dart';
import 'package:greycells/models/payment/order_create_response.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_success_args.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/models/payment/payment_verify.dart';
import 'package:greycells/models/payment/payment_verify_response.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:greycells/repository/payment_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:greycells/extensions.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  int _paymentDiscountId;
  Razorpay _razorPay;
  PaymentRepository _paymentRepository;
  SettingsRepository _settingsRepository;
  AppointmentRepository _appointmentRepository;
  UserRepository _userRepository;

  int paymentId;
  Payment mPaymentForProcessing;

  PaymentBloc() : super(PaymentInitial()) {
    _razorPay = Razorpay();
    _paymentRepository = PaymentRepository();
    _appointmentRepository = AppointmentRepository();
    _userRepository = UserRepository();

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
        orderCreate.userId = _settingsRepository.get(SettingKey.KEY_PATIENT_ID);
        orderCreate.type = event.payment.type;
        OrderCreateResponse response =
            await _paymentRepository.createOrder(orderCreate);
        if (response != null && response.result == true) {
          var options = {
            'key': event.key,
            'amount': int.parse(response.razorPayAmount),
            'name': 'Greycells Wellness',
            'order_id': response.orderId,
            'description': event.payment.type == PaymentType.APPOINTMENT
                ? "Appointment with therapist"
                : "Assessment test",
            'timeout': 300, // in seconds
          };
          paymentId = response.paymentId;
          mPaymentForProcessing = event.payment;
          _paymentDiscountId = event.payment.discountId;
          if (mPaymentForProcessing != null && paymentId != null)
            _razorPay.open(options);
          else
            yield PaymentFailure();
        } else {
          yield PaymentFailure();
        }
      } catch (e) {
        debugPrint(e.toString());
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
          if (mPaymentForProcessing.type == PaymentType.APPOINTMENT) {
            CreateAppointmentRequest createAppointmentRequest =
                mPaymentForProcessing.extras[Strings.createAppointmentRequest];
            if (createAppointmentRequest != null) {
              createAppointmentRequest.paymentId = paymentId;
              createAppointmentRequest.razorPayPaymentId = event.paymentId;
              bool result = await _appointmentRepository
                  .createAppointment(createAppointmentRequest);
              if (result == true) {
                // Schedule notifications
                final localNotifications =
                    await LocalNotifications.getInstance();
                localNotifications.zonedScheduleNotification(
                    "Appointment reminder",
                    "Friendly reminder! Your appointment is scheduled for today.",
                    createAppointmentRequest.appointmentDateTime
                        .subtract(Duration(hours: 3)));

                localNotifications.zonedScheduleNotification(
                    "Appointment reminder",
                    "Your appointment will start in approximately 30 minutes.",
                    createAppointmentRequest.appointmentDateTime
                        .subtract(Duration(minutes: 35)));

                yield PaymentSuccess(PaymentSuccessArgs(
                  paymentType: mPaymentForProcessing.type,
                  paymentId: createAppointmentRequest.razorPayPaymentId,
                  appointmentDate: createAppointmentRequest.appointmentDateTime
                      .readableDate(),
                  appointmentTime: createAppointmentRequest.appointmentDateTime
                      .readableTime(),
                ));
                mPaymentForProcessing = null;
                paymentId = null;
              } else {
                yield PaymentStatusUnknown(event.paymentId);
              }
            }
          } else if (mPaymentForProcessing.type == PaymentType.ASSESSMENT) {
            bool result = await _userRepository.markEligibleForTest(
                patientId: _settingsRepository.get(SettingKey.KEY_PATIENT_ID));

            if (result != null && result == true) {
              yield PaymentSuccess(PaymentSuccessArgs(
                paymentType: mPaymentForProcessing.type,
                paymentId: event.paymentId,
                appointmentDate: "",
                appointmentTime: "",
              ));
            } else
              yield PaymentStatusUnknown(event.paymentId);
          }
        } else
          yield PaymentStatusUnknown(event.paymentId);
      } catch (e) {
        yield PaymentStatusUnknown(event.paymentId);
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
    print(response.code);
    print(response.message);
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
