import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greycells/constants/strings.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        brightness: Brightness.light,
        title: Text(
          "Book Appointment",
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
                PaymentHeaderSection(),
                SizedBox(
                  height: 8.0,
                ),
                Divider(),
                PaymentDetailsSection(),
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
                  child: OutlineButton(
                    onPressed: () {},
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      "MAKE PAYMENT",
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
  }
}

class PaymentHeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO: Check if image available else show initials
        // For Assessment test show icon
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
          radius: 40.0,
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Anne Hathaway",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.clip,
              ),
              Text(
                "Clinical Psychologist",
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Details",
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.w500,
                )),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Text("1 Session",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w300)),
            Spacer(),
            Text(Strings.rupeeSymbol + "300",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w300))
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Visibility(
          visible: true,
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
              Text("- " + Strings.rupeeSymbol + "100",
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
              Text("Total",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w500)),
              Spacer(),
              Text(Strings.rupeeSymbol + "200",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ],
    );
  }
}

class PromoCodeInputSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Do you have a promo code?",
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
                  labelText: "Enter promo code",
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
                "APPLY",
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
