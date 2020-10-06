import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';

class Payment {
  PaymentType type;
  String itemImageUrl;
  String itemTitle;
  String itemSubtitle;
  bool promoCodeApplied;
  List<PaymentItem> items;
  int totalAmount;
}
