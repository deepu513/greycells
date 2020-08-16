import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class QuestionOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        brightness: Brightness.light,
        title: Text(
          "Question 10 of 52",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline),
          )
        ],
      ),
      body: QuestionOptionPageContent(),
    );
  }
}

class QuestionOptionPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: QuestionSection(),
        ),
        Expanded(child: OptionSection()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: QuestionNavigator(),
        )
      ],
    );
  }
}

class QuestionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "I tend to join social organisations when I have an opportunity",
      style: Theme.of(context).textTheme.headline6.copyWith(
            height: 1.2,
            letterSpacing: 0.7,
          ),
    );
  }
}

class OptionSection extends StatefulWidget {
  @override
  _OptionSectionState createState() => _OptionSectionState();
}

class _OptionSectionState extends State<OptionSection> {
  final List<String> options = [
    "Usually",
    "Often",
    "Sometimes",
    "Occasionally",
    "Rarely",
    "Never",
  ];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: index == selectedIndex ? Colors.blueAccent.shade100 : Colors.white,
                  border: Border.all(
                      width: selectedIndex >= 0 ? 0.0 : 0.0,
                      color: index == selectedIndex
                          ? Colors.blueAccent.shade100
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(16.0)),
              child: Text(
                options[index],
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: index == selectedIndex? Colors.white : Colors.black
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 6,
    );
  }
}

class QuestionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          textColor: Theme.of(context).accentColor,
          child: Text(Strings.back.toUpperCase()),
        ),
        RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          onPressed: () {},
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          icon: Icon(
            Icons.save,
            color: Colors.white,
            size: 20.0,
          ),
          label: Text(
            Strings.saveAndNext.toUpperCase(),
          ),
        )
      ],
    );
  }
}
