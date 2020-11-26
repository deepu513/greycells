import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/models/assessment/assessment_response.dart';
import 'package:greycells/models/assessment/personality_type.dart';
import 'package:greycells/view/widgets/circle_text.dart';

class PatientFullScorePage extends StatefulWidget {
  final AssessmentResponse assessment;

  const PatientFullScorePage({Key key, @required this.assessment})
      : super(key: key);

  @override
  _PatientFullScorePageState createState() => _PatientFullScorePageState();
}

class _PatientFullScorePageState extends State<PatientFullScorePage> {
  List<PersonalityType> _filteredList;

  @override
  void initState() {
    super.initState();
    _filteredList = List();
    for (int i = 0; i < widget.assessment.personalityScore.length; i++) {
      PersonalityType type = PersonalityType.values.firstWhere((element) =>
          element.initials() ==
          widget.assessment.personalityScore[i].groupName);
      _filteredList.add(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assessment Score',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        elevation: 4.0,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                "Behaviour",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 3.0,
              margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.grey.shade300)),
                columnWidths: {0: FractionColumnWidth(.3)},
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text("Needs",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0)),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "E",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      fontSize: 20.0,
                                      decoration: TextDecoration.underline),
                              children: [
                                TextSpan(
                                    text: "xpressed",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16.0))
                              ]),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "W",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      fontSize: 20.0,
                                      decoration: TextDecoration.underline),
                              children: [
                                TextSpan(
                                    text: "anted",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16.0))
                              ]),
                        ),
                      ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            text: "I",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline),
                            children: [
                              TextSpan(
                                  text: "nclusion",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16.0))
                            ]),
                      ),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "EI")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.pink.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "WI")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.green.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            text: "C",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline),
                            children: [
                              TextSpan(
                                  text: "ontrol",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16.0))
                            ]),
                      ),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "EC")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.pink.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "WC")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.green.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            text: "A",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline),
                            children: [
                              TextSpan(
                                  text: "ffection",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16.0))
                            ]),
                      ),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "EA")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.pink.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                    CircleText(
                      text: Text(
                        widget.assessment.behaviourScore
                            .firstWhere((element) => element.groupName == "WA")
                            .score
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                      circleColor: Colors.green.shade400,
                      padding: EdgeInsets.all(8.0),
                    ),
                  ]),
                ],
              ),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Personality",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ...List<Widget>.generate(_filteredList.length, (index) {
                    return Container(
                      margin: index == _filteredList.length - 1
                          ? null
                          : EdgeInsets.only(right: 8.0),
                      child: CircleText(
                        text: Text(
                          _filteredList[index].initials(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontFeatures: [
                            FontFeature.tabularFigures(),
                          ], color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        circleColor: _filteredList[index].color(),
                        padding: EdgeInsets.all(8.0),
                      ),
                    );
                  }, growable: false),
                ],
              ),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "All Scores",
                style: Theme.of(context)
                    .textTheme
                    .headline6,
              ),
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: widget.assessment.allPersonalityScore.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleText(
                      text: Text(
                        widget.assessment.allPersonalityScore[index].groupName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontFeatures: [
                          FontFeature.tabularFigures(),
                        ], color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      circleColor: AppTheme.secondaryColor,
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.assessment.allPersonalityScore[index].score
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontFeatures: [
                        FontFeature.tabularFigures(),
                      ], color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
