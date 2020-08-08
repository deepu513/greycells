import 'package:flutter/material.dart';
import 'package:mental_health/view/widgets/height_slider.dart';
import 'package:mental_health/view/widgets/weight_slider.dart';

class HeightCard extends StatefulWidget {
  final int initialWeight;

  const HeightCard({Key key, this.initialWeight}) : super(key: key);

  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    super.initState();
    height = widget.initialWeight ?? 150;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return HeightSlider(
              minValue: 90,
              maxValue: 300,
              value: height,
              onChanged: (val) => setState(() => height = val),
              width: constraints.maxWidth,
            );
          },
        ),
        Positioned(bottom: 24.0,child: Text("cms", style: TextStyle(color: Colors.grey, fontSize: 14.0),)),
        Icon(Icons.arrow_drop_up, size: 24.0,)
      ],
    );
  }
}