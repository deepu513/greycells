import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(Payment payment)
      : assert(payment != null),
        super(PaymentInitial(payment));

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
