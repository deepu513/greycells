import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';

class Payment {
  PaymentType type;
  String title;
  String itemImageUrl;
  String itemTitle;
  String itemSubtitle;
  bool promoCodeApplied;
  int discountId;
  int discountAmount;
  int originalAmount;
  List<PaymentItem> items;
  int totalAmount;
}
