import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NumberSlider extends StatelessWidget {
  NumberSlider(
      {Key key,
      @required this.minValue,
      @required this.maxValue,
      @required this.value,
      @required this.onChanged,
      @required this.width,
      @required this.indicatorText})
      : scrollController = new ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        itemCount = (maxValue - minValue) + 3,
        super(key: key);

  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;
  final double width;
  final ScrollController scrollController;
  final String indicatorText;
  final int itemCount;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 72.0,
          padding: const EdgeInsets.only(top: 24.0),
          child: NotificationListener(
            onNotification: (notification) {
              return _onNotification(notification, width / 3);
            },
            child: new ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemExtent: width / 3,
              itemCount: itemCount,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                int itemValue = _indexToValue(index);
                bool isAtBoundary = index == 0 || index == itemCount - 1;
                return isAtBoundary
                    ? new Container() //empty first and last element
                    : GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _animateTo(itemValue, width / 3,
                            durationMillis: 50),
                        child: FittedBox(
                          child: Text(
                            itemValue.toString(),
                            style: _getTextStyle(itemValue),
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      );
              },
            ),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Icon(
          Icons.arrow_drop_up,
          size: 32.0,
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          indicatorText,
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),

      ],
    );
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(77, 123, 243, 1.0),
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle()
        : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, double itemExtent, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset, double itemExtent) =>
      (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset, double itemExtent) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset, itemExtent);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification notification, double itemExtent) {
    if (notification is ScrollNotification) {
      int middleValue =
          _offsetToMiddleValue(notification.metrics.pixels, itemExtent);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue, itemExtent);
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }
}
