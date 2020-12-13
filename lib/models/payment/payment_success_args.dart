import 'package:flutter/foundation.dart';
import 'package:greycells/models/payment/payment_type.dart';

class PaymentSuccessArgs {
  final PaymentType paymentType;
  final String paymentId;
  final String appointmentDate;
  final String appointmentTime;

  PaymentSuccessArgs(
      {@required this.paymentType,
      @required this.paymentId,
      @required this.appointmentDate,
      @required this.appointmentTime});
}
