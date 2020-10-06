import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/payment/payment_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            brightness: Brightness.light,
            title: Text(
              state.payment.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentHeaderSection(state.payment),
                    SizedBox(
                      height: 8.0,
                    ),
                    Divider(),
                    PaymentDetailsSection(state.payment),
                    Divider(),
                    SizedBox(
                      height: 16.0,
                    ),
                    PromoCodeInputSection(),
                    SizedBox(
                      height: 56.0,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 48.0,
                      child: RaisedButton(
                        onPressed: () {},
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          Strings.proceedToPayment.toUpperCase(),
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 48.0,
                      child: OutlineButton(
                        onPressed: () {},
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          Strings.goBack.toUpperCase(),
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PaymentHeaderSection extends StatelessWidget {
  final Payment payment;

  PaymentHeaderSection(this.payment) : assert(payment != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: payment.type == PaymentType.ASSESSMENT,
            child: Icon(
              Icons.assignment,
              size: 40.0,
            )),
        Visibility(
          visible: payment.type == PaymentType.APPOINTMENT,
          child: CircleAvatar(
            backgroundImage: payment.itemImageUrl != null
                ? NetworkImage(payment.itemImageUrl)
                : null,
            child: payment.itemImageUrl == null
                ? Text(payment.title[0].toUpperCase())
                : null,
            radius: 40.0,
          ),
        ),
        SizedBox(
          width: 16.0,
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

class PaymentDetailsSection extends StatelessWidget {
  final Payment payment;

  PaymentDetailsSection(this.payment) : assert(payment != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.paymentDetails,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.w500,
                )),
        SizedBox(
          height: 8.0,
        ),
        PaymentItems(payment.items),
        SizedBox(
          height: 8.0,
        ),
        Visibility(
          visible: payment.promoCodeApplied,
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
              Text("- " + Strings.rupeeSymbol + "${payment.discountAmount}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.green))
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(Strings.total,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w500)),
              Spacer(),
              Text(Strings.rupeeSymbol + "${payment.totalAmount}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500))
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
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w300)),
              Spacer(),
              Text(Strings.rupeeSymbol + "${items[index].itemPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w300))
            ],
          );
        });
  }
}

class PromoCodeInputSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.promoCodeQuestion,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.w500,
                )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                maxLines: 1,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: Strings.enterPromoCode,
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              width: 48.0,
            ),
            OutlineButton.icon(
              icon: Visibility(
                visible: false,
                child: SizedBox(
                    width: 12.0,
                    height: 12.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    )),
              ),
              onPressed: () {},
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
          ],
        ),
      ],
    );
  }
}
