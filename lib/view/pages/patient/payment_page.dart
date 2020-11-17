import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/payment/discount_bloc.dart';
import 'package:greycells/bloc/payment/payment_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/models/payment/discount_response.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';

class PaymentPage extends StatefulWidget {
  final Payment mPayment;
  PaymentPage(this.mPayment);

  @override
  _PaymentPageState createState() => _PaymentPageState(mPayment);
}

class _PaymentPageState extends State<PaymentPage> {
  final Payment mPayment;

  _PaymentPageState(this.mPayment);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentFailure) {
          widget.showErrorDialog(
              context: context,
              message: ErrorMessages.PAYMENT_ERROR_MESSAGE,
              showIcon: true,
              onPressed: () async {
                Navigator.of(context).pop();
              });
        }

        if (state is PaymentStatusUnknown) {
          widget.showErrorDialog(
              context: context,
              message: Strings.paymentStatusUnknown,
              showIcon: true,
              onPressed: () async {
                Navigator.of(context).pop();
              });
        }

        if (state is PaymentSuccess) {
          // TODO: After payment success show a good page with image and rediredirect to refreshed home page on back.
          widget.showSuccessDialog(
              context: context,
              message: Strings.paymentSuccess,
              showIcon: true,
              onPressed: () async {
                Navigator.of(context).pop();
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            brightness: Brightness.light,
            title: Text(
              mPayment.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PaymentHeaderSection(mPayment),
                        Divider(
                          height: 32.0,
                        ),
                        PaymentDetailsSection(mPayment),
                        Divider(
                          height: 32.0,
                        ),
                        BlocProvider<DiscountBloc>(
                            create: (context) => DiscountBloc(),
                            child: PromoCodeInputSection(
                              onPromoCodeApplied: (discount) =>
                                  _giveDiscount(discount),
                              onPromoCodeRemoved: () => _removeDiscount(),
                            )),
                        Divider(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: state is! PaymentProcessing ? () {
                    BlocProvider.of<PaymentBloc>(context)
                        .add(ProcessPayment(mPayment));
                  } : null,
                  color: Theme.of(context).primaryColor,
                  disabledColor: Colors.grey,
                  height: 56.0,
                  minWidth: double.maxFinite,
                  child: Text(
                    Strings.makePayment.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          wordSpacing: 1.0,
                          letterSpacing: 0.75,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _giveDiscount(DiscountResponse discount) {
    setState(() {
      mPayment.discountId = discount.discountId;
      mPayment.discountAmount =
          ((discount.discountPercent / 100) * mPayment.originalAmount).floor();
      mPayment.totalAmount = mPayment.originalAmount - mPayment.discountAmount;
      mPayment.promoCodeApplied = true;
    });
  }

  _removeDiscount() {
    setState(() {
      mPayment.promoCodeApplied = false;
      mPayment.totalAmount = mPayment.originalAmount;
      mPayment.discountAmount = 0;
      mPayment.discountId = 0;
    });
  }
}

class PaymentHeaderSection extends StatelessWidget {
  final Payment payment;

  PaymentHeaderSection(this.payment) : assert(payment != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
            visible: payment.type == PaymentType.APPOINTMENT,
            child: CircleAvatarOrInitials(
              radius: 32.0,
              imageUrl:
                  payment.itemImageUrl != null ? payment.itemImageUrl : "",
              stringForInitials: payment.itemTitle,
            )),
        SizedBox(
          width: payment.type == PaymentType.APPOINTMENT ? 16.0 : 0.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                payment.itemTitle,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.clip,
              ),
              Text(
                payment.itemSubtitle,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentDetailsSection extends StatefulWidget {
  final Payment payment;

  PaymentDetailsSection(this.payment) : assert(payment != null);

  @override
  _PaymentDetailsSectionState createState() => _PaymentDetailsSectionState();
}

class _PaymentDetailsSectionState extends State<PaymentDetailsSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.paymentDetails,
            style: Theme.of(context).textTheme.caption),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PaymentItems(widget.payment.items),
        ),
        SizedBox(
          height: 8.0,
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Visibility(
              visible: widget.payment.promoCodeApplied == true,
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Promo code applied",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.green.shade50,
                    ),
                  ),
                  Spacer(),
                  Text(
                      "- " +
                          Strings.rupeeSymbol +
                          "${widget.payment.discountAmount}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.green))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xFFF8F9FA)),
          child: Row(
            children: [
              Text(Strings.total,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w700)),
              Spacer(),
              Text(Strings.rupeeSymbol + "${widget.payment.totalAmount}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentItems extends StatelessWidget {
  final List<PaymentItem> items;

  PaymentItems(this.items) : assert(items != null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(items[index].itemName,
                  style: Theme.of(context).textTheme.subtitle1),
              Spacer(),
              Text(Strings.rupeeSymbol + "${items[index].itemPrice}",
                  style: Theme.of(context).textTheme.subtitle1)
            ],
          );
        });
  }
}

class PromoCodeInputSection extends StatefulWidget {
  final ValueChanged<DiscountResponse> onPromoCodeApplied;
  final VoidCallback onPromoCodeRemoved;

  PromoCodeInputSection(
      {@required this.onPromoCodeApplied, @required this.onPromoCodeRemoved});

  @override
  _PromoCodeInputSectionState createState() => _PromoCodeInputSectionState();
}

class _PromoCodeInputSectionState extends State<PromoCodeInputSection> {
  String promoCode;
  @override
  void initState() {
    super.initState();
    promoCode = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if (state is PromoCodeFailed) {
          widget.showErrorDialog(
              context: context,
              message: ErrorMessages.PROMO_CODER_ERROR_MESSAGE,
              showIcon: true,
              onPressed: () async {
                Navigator.of(context).pop();
              });
        }

        if (state is PromoCodeApplied) {
          widget.onPromoCodeApplied.call(state.discountResponse);
        }

        if (state is PromoCodeRemoved) {
          widget.onPromoCodeRemoved.call();
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.promoCodeQuestion,
                style: Theme.of(context).textTheme.caption),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: TextEditingController(text: promoCode ?? ""),
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: Strings.enterPromoCode,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => promoCode = value,
                  ),
                ),
                SizedBox(
                  width: 48.0,
                ),
                Visibility(
                  visible: state is! PromoCodeApplied,
                  child: Expanded(
                    flex: 2,
                    child: OutlineButton.icon(
                      icon: Visibility(
                        visible: state is ApplyingPromoCode,
                        child: SizedBox(
                            width: 12.0,
                            height: 12.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            )),
                      ),
                      onPressed: () {
                        BlocProvider.of<DiscountBloc>(context)
                            .add(ApplyPromoCode(promoCode));
                      },
                      color: Theme.of(context).primaryColor,
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      label: Text(
                        Strings.apply.toUpperCase(),
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: state is PromoCodeApplied,
                  child: Expanded(
                    flex: 2,
                    child: OutlineButton.icon(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.brown,
                        size: 20.0,
                      ),
                      onPressed: () {
                        BlocProvider.of<DiscountBloc>(context)
                            .add(RemovePromoCode());
                      },
                      color: Colors.brown,
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      label: Text(
                        Strings.remove.toUpperCase(),
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.brown,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
