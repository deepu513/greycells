import 'package:flutter/material.dart';
import 'package:mental_health/view/widgets/weight_slider.dart';

class WeightCard extends StatefulWidget {
  final int initialWeight;
  final ValueChanged<int> onWeightChanged;

  const WeightCard({Key key, this.initialWeight, this.onWeightChanged}) : super(key: key);

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  int weight;

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight ?? 70;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return WeightSlider(
              minValue: 30,
              maxValue: 110,
              value: weight,
              onChanged: (val) => setState(() {
                weight = val;
                widget.onWeightChanged(weight);
              }),
              width: constraints.maxWidth,
            );
          },
        ),
        Positioned(bottom: 24.0,child: Text("kgs", style: TextStyle(color: Colors.grey, fontSize: 14.0),)),
        Icon(Icons.arrow_drop_up, size: 24.0,)
      ],
    );
  }
}