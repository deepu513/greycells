import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/linear_loading_indicator.dart';

class TitleWithLoading extends StatefulWidget {
  final String title;
  final bool loadingVisibility;

  TitleWithLoading({@required this.title, this.loadingVisibility = false});

  @override
  _TitleWithLoadingState createState() => _TitleWithLoadingState();
}

class _TitleWithLoadingState extends State<TitleWithLoading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.0,
              ),
              LinearLoadingIndicator(
                visibility: widget.loadingVisibility,
              )
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(),
        )
      ],
    );
  }
}
