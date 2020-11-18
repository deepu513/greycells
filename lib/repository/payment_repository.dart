import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/payment/discount_request.dart';
import 'package:greycells/models/payment/discount_request_serializable.dart';
import 'package:greycells/models/payment/discount_response.dart';
import 'package:greycells/models/payment/discount_response_serializable.dart';
import 'package:greycells/models/payment/order_create.dart';
import 'package:greycells/models/payment/order_create_response.dart';
import 'package:greycells/models/payment/order_create_response_serializable.dart';
import 'package:greycells/models/payment/order_create_serializable.dart';
import 'package:greycells/models/payment/payment_verify.dart';
import 'package:greycells/models/payment/payment_verify_response.dart';
import 'package:greycells/models/payment/payment_verify_response_serializable.dart';
import 'package:greycells/models/payment/payment_verify_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class PaymentRepository {
  HttpService _httpService;
  DiscountRequestSerializable _discountRequestSerializable;
  DiscountResponseSerializable _discountResponseSerializable;

  OrderCreateSerializable _orderCreateSerializable;
  OrderCreateResponseSerializable _orderCreateResponseSerializable;

  PaymentVerifySerializable _paymentVerifySerializable;
  PaymentVerifyResponseSerializable _paymentVerifyResponseSerializable;

  PaymentRepository() {
    _httpService = HttpService();
    _discountRequestSerializable = DiscountRequestSerializable();
    _discountResponseSerializable = DiscountResponseSerializable();
    _orderCreateSerializable = OrderCreateSerializable();
    _orderCreateResponseSerializable = OrderCreateResponseSerializable();
    _paymentVerifySerializable = PaymentVerifySerializable();
    _paymentVerifyResponseSerializable = PaymentVerifyResponseSerializable();
  }

  Future<DiscountResponse> requestDiscount(
      DiscountRequest discountRequest) async {
    Request<DiscountRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Discount/Percent",
        _discountRequestSerializable)
      ..setBody(discountRequest);

    return await _httpService.post(request, _discountResponseSerializable);
  }

  Future<OrderCreateResponse> createOrder(
      OrderCreate orderCreateRequest) async {
    Request<OrderCreate> request = Request(
        "${FlavorConfig.getBaseUrl()}Payment/Create", _orderCreateSerializable)
      ..setBody(orderCreateRequest);

    return await _httpService.post(request, _orderCreateResponseSerializable);
  }

  Future<PaymentVerifyResponse> verifyPayment(
      PaymentVerify paymentVerify) async {
    Request<PaymentVerify> request = Request(
        "${FlavorConfig.getBaseUrl()}Payment/Verify",
        _paymentVerifySerializable)
      ..setBody(paymentVerify);

    return await _httpService.post(request, _paymentVerifyResponseSerializable);
  }
}
