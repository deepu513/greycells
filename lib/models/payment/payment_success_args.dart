import 'package:flutter/foundation.dart';

class PaymentSuccessArgs {
  final String paymentId;
  final String appointmentDate;
  final String appointmentTime;

  PaymentSuccessArgs(
      {@required this.paymentId,
      @required this.appointmentDate,
      @required this.appointmentTime});
}
